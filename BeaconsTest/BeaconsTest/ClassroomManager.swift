//
//  ClassroomManager.swift
//  BeaconsTest
//
//  Created by Michael on 15/08/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//

import Foundation
import Alamofire

class ClassroomManager {
    static let sharedInstance = ClassroomManager()
    
    private var classrooms = [Classroom]()
    
    func getClassrooms() -> [Classroom] {
        return self.classrooms
    }
    
    func addClassroom(classroom: Classroom) {
        self.classrooms.append(classroom)
    }
    
    func fetchClassroomsFromAPI() {
        Alamofire.request(.GET, "http://178.62.216.72/api/locations?access-token=\(APIManager.sharedInstance.getAccessToken())", parameters: nil).responseJSON {
            response in
            
            if let JSON = response.result.value {
                for location in JSON as! [Dictionary<String, AnyObject>] {
                    self.addClassroom(Classroom(id: location["id"] as! Int, name: location["name"] as! String, beaconMinor: location["beacon"] as! String))
                }
            }
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
            
            for classroom in self.classrooms {
                Alamofire.request(.GET, "http://178.62.216.72/api/locations/\(classroom.getId())?access-token=\(APIManager.sharedInstance.getAccessToken())", parameters: nil).responseJSON {
                    response in
                    
                    var students = [Int]()
                    
                    if let JSON = response.result.value {
                        if let checkins = JSON["check_ins"] {
                            for checkin in checkins as! [Dictionary<String, AnyObject>] {
                                let date = dateFormatter.dateFromString(checkin["creation_date"] as! String)
                                let timeDiff = date!.timeIntervalSinceNow / 60 / 60
                                
                                if timeDiff > -24 {
                                    let user = checkin["user"]! as! Dictionary<String, AnyObject>
                                    let userId = user["id"] as! Int
                                    
                                    if !students.contains(userId) {
                                        students.append(userId)
                                        let student = Student(id: userId, firstName: user["first_name"] as! String, lastName: user["last_name"] as! String)
                                        classroom.addCurrentStudents(student)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
