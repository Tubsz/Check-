//
//  UserManager.swift
//  BeaconsTest
//
//  Created by Michael on 15/08/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//

import Foundation

class APIManager {
    static let sharedInstance = APIManager()
    
    private var accessToken = ""
    private var email = ""
    private var password = ""
    private var firstName = ""
    private var lastName = ""
    private var docent = false
    
    func getAccessToken() -> String {
        return self.accessToken
    }
    
    func setAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
    func getFirstName() -> String {
        return self.firstName
    }
    
    func setFirstname(firstName: String) {
        self.firstName = firstName
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func setLastName(lastName: String) {
        self.lastName = lastName
    }
    
    func isDocent() -> Bool {
        return self.docent
    }
    
    func setDocent(docent: Bool) {
        self.docent = docent
    }
    
    func logout() {
        self.accessToken = ""
        self.email = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.docent = false
    }
}
