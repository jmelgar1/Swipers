//
//  SellerKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit
import CoreLocation
import ProgressHUD
import FirebaseFirestore
import FirebaseAuth

class SellerCampusController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let UserDefault: UserDefaults = UserDefaults.standard
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    var campusType: String = ""
    var campus: String = ""
    
    //go to finding buyer screen when start selling button pressed
    @IBAction func startSellingPressed(_ sender: Any)
    {
        let InBounds = UserDefaults.standard.bool(forKey: "InBounds")
        
        if(InBounds == true){
            putSellerOnSellList()
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
        } else if (campusType == "Stingers") {
            locationManager.startMonitoring(for: Utilities.getMariettaCampusCoords())
        } else {
            showError("Can not find campus type. Contact support!")
        }

        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
        
        enterPriceTextField.delegate = self
        
        self.title = campusType
    }
    
    //gets current location (coordinates) of user
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
    
    //Only allow decimal numbers in the price text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
          guard !s.isEmpty else { return true }
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .none
          return numberFormatter.number(from: s)?.intValue != nil
     }
    
    func putSellerOnSellList(){
        
        if(campusType == "The Commons"){
            campus = "Kennesaw"
        } else {
            campus = "Marietta"
        }
    
        //get current user uid
        let userID = Auth.auth().currentUser!.uid
        
        //assign database to variable
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let firstName = (document.get("first_name") as? String)!
                let lastName = (document.get("last_name") as? String)!
                let phoneNumber = (document.get("phone_number") as? String)!
                
                db.collection("sellers\(self.campus)").document(userID).setData(["first_name":firstName,"last_name":lastName,"phone_number":phoneNumber]) { (error) in
                    
                    if error != nil {
                        
                        //go back to sell page if something fails
                        self.showError("Error assigning user to sell list.")
                        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
                    } else {
                        
                        //go to searching for buyer view
                        self.performSegue(withIdentifier: "SearchSegue", sender: self)
                    }
                }
            } else {
                showError("Can not retrieve user data")
            }
        }
    }
    
    func showError(_ message:String) {
        ProgressHUD.showError(message)
    }
}
