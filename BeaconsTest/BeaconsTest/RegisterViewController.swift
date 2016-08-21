//
//  RegisterScreen.swift
//  BeaconsTest
//
//  Created by Michael on 29/12/15.
//  Copyright © 2015 Smets Michael. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var usersurname: UITextField!
    @IBOutlet var userpw: UITextField!
    @IBOutlet var usermail: UITextField!
    @IBOutlet var userpwrpt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func sendRegister() {
        let usrName = username.text!
        let usrSurname = usersurname.text!
        let usrPw = userpw.text!
        let usrEmail = usermail.text!
        
        Alamofire.request(.POST, "http://178.62.216.72/api/users" , parameters: ["email":usrEmail, "firstname":usrSurname, "lastname":usrName, "password":usrPw]).responseJSON { response in
            if let JSON = response.result.value {
                if let message = JSON["message"] as? NSString {
                    let alertController = UIAlertController(title:message as String, message:
                        "Please enter a valid e-mail adress", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Thank you!", message:
                        "Thanks for registering", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func registerDone(sender: AnyObject) {
        if username.text == "" || usersurname.text == "" || userpw.text == "" || usermail.text == "" {
            let alertController = UIAlertController(title: "Invalid", message:
                "Please fill in all the fields and make sure you're using an e-mail from the school.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            if !usermail.text!.hasSuffix("@student.ehb.be") {
                let alertController = UIAlertController(title: "Wrong e-mail adress", message:
                    "Please fill in a school e-mail adress", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            sendRegister()
        }
    }
}
