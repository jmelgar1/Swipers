//
//  SFBKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/29/22.
//

import UIKit
import CoreLocation

class SFBController: UIViewController {
    
    var locationData:CLLocationManager?
    var campusType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            if(campusType == "The Commons"){
                locationData!.stopMonitoring(for: Utilities.getKennesawCampusCoords())
                //need to remove document
            } else {
                locationData!.stopMonitoring(for: Utilities.getMariettaCampusCoords())
                //need to remove document
            }
        }
    }
}
