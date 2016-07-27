//
//  TacoListTableViewController.swift
//  Taco Stand
//
//  Created by Ryan Cortez on 7/26/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit

class TacoListTableViewController: UITableViewController, AddNewTacoTableViewControllerDelegate {

    var taco = Taco()
    var tacos: Array<Taco> = Array()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        getTacoList()
    }
    
    // MARK: - Fetch Data
    
    func getTacoList () {
        let apiString = "http://taco-stand.herokuapp.com/api/tacos/"
        guard let url = NSURL(string: apiString) else {
            print("String(\(apiString)) was not a valid url"); return
        }
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            guard let tacoData = data else {
                print("JSON could not be created from the raw NSData"); return
            }
            do {
                guard let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(tacoData, options: .AllowFragments) as? Dictionary<String,AnyObject> else {
                    print("JSON data was not formatted as a Dictionary"); return
                }
                let key = "tacos"
                guard let array = jsonDictionary[key] as? Array<AnyObject> else {
                    print("Did not find array in \(key) dictionary"); return
                }
                for tacoDictionary in array {
                    let nameKey = "name"
                    let priceKey = "price"
                    let photoURLKey = "photo_url"
                    guard let name = tacoDictionary.valueForKey(nameKey) as? String else {
                        print("Did not find string in key(\(nameKey))"); return
                    }
                    guard let price = tacoDictionary.valueForKey("price") as? String else {
                        print("Did not find float in key (\(priceKey))"); return
                    }
                    guard let photoURL = tacoDictionary.valueForKey("photo_url") as? String else {
                        print("Did not find string in key (\(photoURLKey))"); return
                    }
                    
                    let taco = Taco(name: name, price: price, imageURL: photoURL)
                    self.tacos.append(taco)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } catch {
                print("Could not serialize the data into JSON")
            }
        }.resume()
    }
    
    // MARK: - AddNewTacoTableViewController Delgate 
    func tacoHasBeenAdded(newTaco newTaco: Taco) {
        tacos.append(newTaco)
        self.tableView.reloadData()
    }
    
    // MARK: - TableView Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tacos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCellWithIdentifier("tacoCell") as? TacoTableViewCell else {
            print("Could not convert UITableViewCell to TacoTableViewCell")
            let blankCell = UITableViewCell()
            return blankCell
        }
        cell.tacoImageView.image = UIImage()
        cell.tacoLabel.text = tacos[indexPath.row].name
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) { 
            let photoURLString = self.tacos[indexPath.row].imageURL
            guard let url = NSURL(string: photoURLString) else {
                print("Did not find string with a valid URL")
                return
            }
            guard let data = NSData(contentsOfURL: url) else {
                print("Did not find data at URL(\(photoURLString))")
                return
            }
            let image = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue()) {
                cell.tacoImageView.image = image
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.taco = tacos[indexPath.row]
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tacoListToTacoDetail") {
            guard let destinationViewController = segue.destinationViewController as? TacoDetailTableViewController else {
                print("destinationViewController was not a TacoDetailTableViewController"); return
            }
            
            destinationViewController.taco = self.taco
        }
        if (segue.identifier == "tacoListToAddTaco") {
            guard let navigationController = segue.destinationViewController as? UINavigationController else {
                print("segue.destinationViewController was not a UINavigationController"); return
            }
            guard let destinationViewController = navigationController.viewControllers.first as? AddNewTacoTableViewController else {
                print("navigationController.viewControllers.first was not a AddNewTacoTableViewController"); return
            }
            destinationViewController.delegate = self
        }
    }

}

