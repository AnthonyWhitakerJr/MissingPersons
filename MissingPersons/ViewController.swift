//
//  ViewController.swift
//  MissingPersons
//
//  Created by Anthony Whitaker on 10/3/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let defaultImage: UIImage = #imageLiteral(resourceName: "Profile")
    var selectedMissingPerson: Person?
    var selectedPhotoPerson: Person!
        
    let missingPeople = [
        Person(personImageUrl: "person1.jpg"),
        Person(personImageUrl: "person2.jpg"),
        Person(personImageUrl: "person3.jpg"),
        Person(personImageUrl: "person4.jpg"),
        Person(personImageUrl: "person5.jpg"),
        Person(personImageUrl: "person6.png"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loadPicker(gesture:)))
        tap.numberOfTapsRequired = 1
        selectedImage.addGestureRecognizer(tap)
        
        selectedPhotoPerson = Person()
        updateSelectedPhoto(image: defaultImage)
    }
    
    func updateSelectedPhoto(image: UIImage) {
        selectedPhotoPerson?.personImage = image
        selectedImage.image = image
        selectedPhotoPerson.faceId = nil
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Select Person & Image", message: "Please select a missing person to check and an image from your photos.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkForMatchPressed(_ sender: AnyObject) {
        if selectedMissingPerson == nil || selectedPhotoPerson.personImage == defaultImage {
            showErrorAlert()
        } else {
            if let myImg = selectedImage.image, let imgData = UIImageJPEGRepresentation(myImg, 0.8) {
                FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces: [MPOFace]?, err: Error?) in
                    if err == nil {
                        var faceId: String?
                        for face in faces! {
                            faceId = face.faceId
                            self.selectedPhotoPerson.faceId = faceId
                            break
                        }
                        
                        if faceId != nil {
                            FaceService.instance.client?.verify(withFirstFaceId: self.selectedMissingPerson!.faceId, faceId2: faceId, completionBlock: { (result: MPOVerifyResult?, err: Error?) in
                                if err == nil {
                                print(result?.confidence)
                                print(result?.isIdentical)
                                print(result.debugDescription)
                                } else {
                                    print(err.debugDescription)
                                }
                            })
                        }
                    } else {
                        print(err.debugDescription)
                    }
                })
            }
        }
        print("END")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missingPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        let person = missingPeople[indexPath.row]
        cell.configureCell(person: person)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMissingPerson = missingPeople[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! PersonCell
        cell.setSelected()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            updateSelectedPhoto(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loadPicker(gesture: UITapGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
}

