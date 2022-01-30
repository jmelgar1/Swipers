//
//  SellerKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import CoreLocation

class SellerCampusController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    var campusType: String = ""
    
    //go to finding buyer screen when start selling button pressed
    @IBAction func startSellingPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "KennesawSearchSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //geofencing setup
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        
        locationManager.startMonitoring(for: Utilities.getKennesawCampusCoords())
        
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
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        print(region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(region.identifier)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
          guard !s.isEmpty else { return true }
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .none
          return numberFormatter.number(from: s)?.intValue != nil
     }
}
