//
//  ClassroomViewController.swift
//  BeaconsTest
//
//  Created by Michael on 15/08/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//

import Foundation
import UIKit

class ClassroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblClassrooms: UITableView!
    
    override func viewDidLoad() {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ClassroomViewController.updateTable), userInfo: nil, repeats: false)
    }
    
    func updateTable() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tblClassrooms.reloadData()
        })

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassroomManager.sharedInstance.getClassrooms().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {        
        let cell = self.tblClassrooms.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = ClassroomManager.sharedInstance.getClassrooms()[indexPath.row].getName()
        cell.detailTextLabel!.text = "\(ClassroomManager.sharedInstance.getClassrooms()[indexPath.row].getCurrentStudentsCount()) student(en) aanwezig"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showStudents", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showStudents") {
            let dvc = (segue.destinationViewController as! ClassroomStudentsViewController)
            dvc.classroom = sender as! Int
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
