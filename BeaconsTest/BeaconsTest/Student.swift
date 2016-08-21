//
//  Student.swift
//  BeaconsTest
//
//  Created by Michael on 15/08/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//

import Foundation

class Student {
    private var id: Int
    private var firstName: String
    private var lastName: String
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getFirstName() -> String {
        return self.firstName
    }
    
    func setFirstName(firstName: String) {
        self.firstName = firstName
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func setLastName(lastName: String) {
        self.lastName = lastName
    }
}
