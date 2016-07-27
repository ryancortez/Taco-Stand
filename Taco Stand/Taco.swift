//
//  Taco.swift
//  Taco Stand
//
//  Created by Ryan Cortez on 7/26/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit

class Taco: NSObject {
    
    let name: String
    let price: String
    let imageURL: String
    var image: UIImage?
    
    override init() {
        self.name = ""
        self.price = "$0.00"
        self.imageURL = ""
        self.image = nil
        super.init()
    }
    
    init(name: String, price: String, imageURL: String) {
        self.name = name
        self.price = price
        self.imageURL = imageURL
        self.image = nil
        super.init()
        getImage(imageURLString: imageURL)
    }
    
    func getImage(imageURLString urlString:String) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
            guard let url = NSURL(string: urlString) else {
                print("Did not find string with a valid URL")
                return
            }
            guard let data = NSData(contentsOfURL: url) else {
                print("Did not find data at URL(\(urlString))")
                return
            }
            guard let image = UIImage(data: data) else {
                print("Taco: Did not find an image in the NSData")
                return
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.image = image
            }
        }
    }
}
