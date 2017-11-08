//
//  ViewController.swift
//  bucket list one
//
//  Created by elva wang on 11/7/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit

class BucketViewController: UITableViewController, DelegationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var bucket = ["x","xx","xxx"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucket.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath)
        cell.textLabel?.text = bucket[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editItem", sender: indexPath)
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "editItem", sender: indexPath)
//    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        bucket.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "editItem" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! AddItemViewController
            controller.delegate = self

            let indexP = sender as! NSIndexPath
            let item = bucket[indexP.row]
            controller.prePopulate = item
            controller.indexPath = indexP
        }
       
    }
    func cancelPressedFunc(by controller: AddItemViewController) {
        print("I am the hidden controller, but I am reponding to the cancel button press on top view controller")
        
        dismiss(animated: true, completion: nil)
    }
    func textSaveFunc(by controlelr: AddItemViewController, with text: String, at indexPath: NSIndexPath?) {
        print("XXXXXXXXXXXX")
        if let ip = indexPath {
            bucket[ip.row] = text
        } else {
            bucket.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }

}

