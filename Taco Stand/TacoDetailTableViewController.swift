//
//  TacoDetailTableViewController.swift
//  Taco Stand
//
//  Created by Ryan on 7/26/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit

class TacoDetailTableViewController: UITableViewController {
    var taco: Taco = Taco()
    
    // MARK: - Outlets
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // MARK: - ViewController Lifecycle 
    
    override func viewDidLoad() {
        name.text = taco.name
        price.text = "\(taco.price)"
        largeImage.image = taco.image
    }
    
    // MARK: - Fetch Data
    
    func getImage(atURL urlString: String) -> UIImage? {
        guard let url = NSURL(string: urlString) else {
            print("String(\(urlString)) did not contain a valid URL"); return nil
        }
        guard let data = NSData(contentsOfURL: url) else {
            print("TacoDetailTableViewController: Did not find image data at the URL\(url.description)"); return nil
        }
        let image = UIImage(data: data)
        return image
    }
    
}
