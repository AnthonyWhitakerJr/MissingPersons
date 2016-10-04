//
//  Person.swift
//  MissingPersons
//
//  Created by Anthony Whitaker on 10/3/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit
import ProjectOxfordFace

class Person {
    private static let baseURL = "http://localHost:6069/img/"

    var faceId: String?
    var personImage: UIImage?
    var personImageUrl: URL?
    
    init() {}
    
    init(personImageUrl: String) {
        self.personImageUrl = URL(string: "\(Person.baseURL)\(personImageUrl)")
    }
    
    func downloadFaceId() {
        guard self.faceId == nil else { return }
        
        if let img = personImage, let imgData = UIImageJPEGRepresentation(img, 0.8) {
            FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces:[MPOFace]?, err:Error?) in
                if err == nil {
                    var faceId: String?
                    if let faces = faces {
                        for face in faces {
                            faceId = face.faceId
                            print(faceId)
                            break
                        }
                        
                        self.faceId = faceId
                    }
                    
                }
            })
        }
    }
}
