//
//  SellerKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import CoreLocation
import ProgressHUD

class SellerCampusController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let UserDefault: UserDefaults = UserDefaults.standard
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    var campusType: String = ""
    
    //go to finding buyer screen when start selling button pressed
    @IBAction func startSellingPressed(_ sender: Any)
    {
        let InBounds = UserDefaults.standard.bool(forKey: "InBounds")
        
        if(InBounds == true){
            self.performSegue(withIdentifier: "KennesawSearchSegue", sender: self)
        } else {
            showError("Please move closer to \(campusType)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //geofencing setup
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        
        //check which campus the user is on
        if(campusType == "The Commons"){
            locationManager.startMonitoring(for: Utilities.getKennesawCampusCoords())
        } else {
            locationManager.startMonitoring(for: Utilities.getMariettaCampusCoords())
        }

        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
        
        enterPriceTextField.delegate = self
        
        self.title = campusType
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        for currentLocation in locations{
            print("\(index): \(currentLocation)")
        }
    }
    
    //check if user has entered geofence
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        print("Entered: \(region.identifier)")
        UserDefault.set(true, forKey: "InBounds")
    }
    
    //check if user has exited the geofence
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
        UserDefault.set(false, forKey: "InBounds")
    }
    
    //check if user is inside geofence when monitoring starts
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {

        switch state {
        case .inside:
            UserDefault.set(true, forKey: "InBounds")
            print("inside region")
        case .outside:
            UserDefault.set(false, forKey: "InBounds")
            print("outside region")
        default:
            UserDefault.set(true, forKey: "InBounds")
            print("default case")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
          guard !s.isEmpty else { return true }
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .none
          return numberFormatter.number(from: s)?.intValue != nil
     }
    
    func showError(_ message:String) {
        ProgressHUD.showError(message)
    }
}
