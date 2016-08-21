//
//  ViewController.swift
//  BeaconsTest
//
//  Created by Michael on 11/11/15.
//  Copyright © 2015 Smets Michael. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class StudentViewController: UIViewController, CLLocationManagerDelegate {
    internal var tracking = true
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var swTracking: UISwitch!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        studentNameLbl.text = APIManager.sharedInstance.getFirstName()

        locationManager.delegate = self;
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        toggleTracking()
    }
    
    @IBAction func changeTrackingSwitch(sender: AnyObject) {
        if swTracking.on {
            tracking = true
        } else {
            tracking = false
        }
        
        toggleTracking()
    }
    
    func toggleTracking() {
        let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")

        if self.tracking {
            locationManager.startRangingBeaconsInRegion(region)
        } else {
            locationManager.stopRangingBeaconsInRegion(region)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            
            for classroom in ClassroomManager.sharedInstance.getClassrooms() {
                if classroom.insideClassroom("\(closestBeacon.minor.integerValue)") {
                    classLabel.text = classroom.getName()
                    
                    Alamofire.request(.POST, "http://178.62.216.72/api/checkins/\(classroom.getId())?access-token=\(APIManager.sharedInstance.getAccessToken())", parameters: nil).responseJSON {response in}
                }
            }
        }
    }
}

