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
    
    func getDataFromUrl(url: NSURL, completion: @escaping ((_ data: NSData?, _ response: URLResponse?, _ error: NSError?) -> Void)) {
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            completion(_: data as NSData?, response, error as NSError?)
            }.resume()
    }
}
