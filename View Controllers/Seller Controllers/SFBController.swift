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
    
    @objc override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            if(campusType == "The Commons"){
                locationData!.stopMonitoring(for: Utilities.getKennesawCampusCoords())
                
                NotificationCenter.default.post(name: Notification.Name.Action.CallRemoveMethod, object: nil)
            } else {
                locationData!.stopMonitoring(for: Utilities.getMariettaCampusCoords())
                
                NotificationCenter.default.post(name: Notification.Name.Action.CallRemoveMethod, object: nil)
            }
        }
    }
}

extension Notification.Name {
    struct Action {
        static let CallRemoveMethod = Notification.Name("CallRemoveMethod")
    }
}
