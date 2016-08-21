//
//  Classroom.swift
//  BeaconsTest
//
//  Created by Michael on 27/11/15.
//  Copyright © 2015 Smets Michael. All rights reserved.
//

import Foundation

class Classroom {
    private var id: Int
    private var name: String
    private var beaconMinor: String
    private var currentStudents = [Student]()

    init(id: Int, name: String, beaconMinor: String) {
        self.id = id
        self.name = name
        self.beaconMinor = beaconMinor
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getName() -> String  {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getBeacon() -> String {
        return self.beaconMinor
    }
    
    func setBeacon(beaconMinor: String) {
        self.beaconMinor = beaconMinor
    }
    
    func getCurrentStudents() -> [Student] {
        return self.currentStudents
    }
    
    func getCurrentStudentsCount() -> Int {
        return self.currentStudents.count
    }
    
    func addCurrentStudents(student: Student) {
        self.currentStudents.append(student)
    }
    
    func insideClassroom(beaconMinor: String) -> Bool {
        if beaconMinor == self.beaconMinor {
            return true
        } else {
            return false
        }
    }
}