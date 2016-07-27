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
    
    override init() {
        self.name = ""
        self.price = "$0.00"
        self.imageURL = ""
        super.init()
    }
    
    init(name: String, price: String, imageURL: String) {
        self.name = name
        self.price = price
        self.imageURL = imageURL
        super.init()
    }
    

}
