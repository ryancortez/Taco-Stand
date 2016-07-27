//
//  AddNewTacoTableViewController.swift
//  Taco Stand
//
//  Created by Ryan on 7/26/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit

protocol AddNewTacoTableViewControllerDelegate {
    func tacoHasBeenAdded(newTaco newTaco: Taco)
}

class AddNewTacoTableViewController: UITableViewController {
    
    var delegate: AddNewTacoTableViewControllerDelegate!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveButtonPressed(sender: AnyObject) {
        guard let title = titleTextField.text else {
            print("Did not recieve title from titleTextField.text, recieved this (\(titleTextField.text))")
            return
        }
        guard let price = priceTextField.text else {
            print("Did not recieve title from priceTextField.text, recieved this (\(priceTextField.text))")
            return
        }
        guard let imageURL = imageURLTextField.text else {
            print("Did not recieve title from imageURLTextField.text, recieved this (\(imageURLTextField.text))")
            return
        }
        let taco = Taco(name: title, price: price, imageURL: imageURL)
        delegate.tacoHasBeenAdded(newTaco: taco)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
