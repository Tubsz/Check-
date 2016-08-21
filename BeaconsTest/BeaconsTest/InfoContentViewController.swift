//
//  InfoContentViewController.swift
//  BeaconsTest
//
//  Created by Michael on 19/01/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//
//  Used Swift ios9 Book p.379


import Foundation
import UIKit
import ChameleonFramework

class InfoContentViewController : UIViewController {
    
    @IBOutlet var headingtextLabel: UILabel!
    @IBOutlet var contenttextLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        headingtextLabel.text = heading
        contenttextLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        if case 0...1 = index {
            nextButton.setTitle("NEXT", forState: UIControlState.Normal)
        } else if case 2 = index {
            nextButton.setTitle("DONE", forState: UIControlState.Normal)
        }

    }
    
  @IBAction func nextButtonTap(sender: AnyObject) {
            
            switch index {
    case 0...1:
        let pageViewController = parentViewController as! InfoPageViewController
    pageViewController.forward(index)
                
    case 2:
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalktrough")
        
        dismissViewControllerAnimated(true, completion: nil)
                
    default: break
        
            }
    }    
}