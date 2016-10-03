//
//  PersonCell.swift
//  MissingPersons
//
//  Created by Anthony Whitaker on 10/3/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    @IBOutlet weak var personImage: UIImageView!
    
    func configureCell(imageUrl: String) {
        
    }
    
    func downloadImage(url: NSURL) {
        
    }
    
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
        }.resume()
    }
}
