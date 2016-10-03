//
//  ViewController.swift
//  MissingPersons
//
//  Created by Anthony Whitaker on 10/3/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    let baseURL = "http://localHost:6069/img"
    let missingPeople = [
    "person1.jpg",
    "person2.jpg",
    "person3.jpg",
    "person4.jpg",
    "person5.jpg",
    "person6.png",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }


    @IBAction func checkForMatchPressed(_ sender: AnyObject) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missingPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        return cell
    }
    
}

