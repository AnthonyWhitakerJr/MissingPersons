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
        if let url = URL(string: imageUrl) {
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: URL) {
        getData(from: url) { (data, response, error) in
            DispatchQueue.main.async(execute: { 
                guard let data = data, error == nil else {return}
                self.personImage.image = UIImage(data: data)
            })
        }
    }
    
    func getData(from url: URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(_: data, response, error)
            }.resume()
    }
}
