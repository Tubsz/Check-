//
//  ClassroomStudentsViewController.swift
//  BeaconsTest
//
//  Created by Michael on 15/08/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//

import Foundation
import UIKit

class ClassroomStudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblStudents: UITableView!
    var classroom: Int = 0
    
    override func viewDidLoad() {

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassroomManager.sharedInstance.getClassrooms()[self.classroom].getCurrentStudentsCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let student = ClassroomManager.sharedInstance.getClassrooms()[self.classroom].getCurrentStudents()[indexPath.row]
        
        let cell = self.tblStudents.dequeueReusableCellWithIdentifier("studentCell")! as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = "\(student.getFirstName()) \(student.getLastName())"
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func print(sender: AnyObject) {
        let priorBounds:CGRect = self.tblStudents.bounds;
        
        let fittedSize:CGSize = self.tblStudents.sizeThatFits(CGSizeMake(priorBounds.size.width, self.tblStudents.contentSize.height))
        self.tblStudents.bounds = CGRectMake(0, 0, fittedSize.width, fittedSize.height)
        
        let pdfPageBounds:CGRect = CGRectMake(0, 0, 792, 612)
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        
        for var pageOriginY:CGFloat = 0; pageOriginY < fittedSize.height; pageOriginY += pdfPageBounds.size.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            CGContextSaveGState(UIGraphicsGetCurrentContext())
            CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, -pageOriginY)
            self.tblStudents.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        }
        
        UIGraphicsEndPDFContext()
        
        self.tblStudents.bounds = priorBounds
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let pdfFileName = path.stringByAppendingPathComponent("Studentoverview.pdf")
        
        pdfData.writeToFile(pdfFileName, atomically: true)
    }
}