//
//  LoginScreen.swift
//  BeaconsTest
//
//  Created by Michael on 14/12/15.
//  Copyright © 2015 Smets Michael. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import Alamofire


class LoginViewController: UIViewController {
    @IBOutlet var usermail: UITextField!
    @IBOutlet var userpw: UITextField!
    
    @IBAction func loginBtn(sender: AnyObject) {
        if usermail.text == "" || userpw.text == "" {
            let alertController = UIAlertController(title: "Invalid", message:
                "Please fill in all the fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        
        let usrPw = userpw.text!
        let usrEmail = usermail.text!
        
        Alamofire.request(.POST, "http://178.62.216.72/api/access-tokens" , parameters: ["email":usrEmail, "password":usrPw]).responseJSON {
            response in
            
            var success = false
            
            if let JSON = response.result.value {
                if let loginToken = JSON["access_token"] as? String {
                    APIManager.sharedInstance.setEmail(usrEmail)
                    APIManager.sharedInstance.setPassword(usrPw)
                    APIManager.sharedInstance.setAccessToken(loginToken)
                    success = true
                }
            }
            
            if !success {
                let alertController = UIAlertController(title: "Fail", message:"Did you type a mistake?", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Oops", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return;
            }
            
            ClassroomManager.sharedInstance.fetchClassroomsFromAPI()
            
            Alamofire.request(.GET, "http://178.62.216.72/api/users/me?access-token=\(APIManager.sharedInstance.getAccessToken())", parameters: nil).responseJSON {
                response in
                
                if let JSON = response.result.value {
                    APIManager.sharedInstance.setFirstname(JSON["first_name"] as! String)
                    APIManager.sharedInstance.setLastName(JSON["last_name"] as! String)
                    APIManager.sharedInstance.setEmail(JSON["email"] as! String)
                    APIManager.sharedInstance.setDocent(JSON["docent"] as! Bool)
                    
                    if APIManager.sharedInstance.isDocent() {
                        self.performSegueWithIdentifier("docentSegue", sender: nil)
                    } else {
                        self.performSegueWithIdentifier("studentSegue", sender: nil)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalktrough = defaults.boolForKey("hasViewedWalktrough")
        
        if hasViewedWalktrough {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("InfoController") as? InfoPageViewController {
            presentViewController(pageViewController, animated: true, completion: nil)
        }
    }
        
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        APIManager.sharedInstance.logout()
        userpw.text = ""
        usermail.text = ""
    }
}