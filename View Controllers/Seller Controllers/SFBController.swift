//
//  SFBKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/29/22.
//

import UIKit
import CoreLocation

class SFBController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            //unfinished. need to remove document once screen is exited
        }
    }
}
