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
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.uid
    
    var campusType: String = ""
    var campus: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeSellerFromSellList), name: Notification.Name.Action.CallRemoveMethod, object: nil)
        
        //geofencing setup
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100

        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
        
        enterPriceTextField.delegate = self
        
        self.title = campusType
        
        startMonitoringRegions()
        
        //get campus variable for adding/removing to sell list
        if(campusType == "The Commons"){
            campus = "Kennesaw"
        } else {
            campus = "Marietta"
        }
    }
    
    //go to finding buyer screen when start selling button pressed
    @IBAction func startSellingPressed(_ sender: Any)
    {
        startMonitoringRegions()
        
        let InBounds = UserDefaults.standard.bool(forKey: "InBounds")
        
        if(InBounds == true){
            
            self.performSegue(withIdentifier: "SearchSegue", sender: self)
            
            addSellerToSellList()
            
        } else {
            Utilities.showError("Please move closer to \(campusType) and try again.")
        }
    }
    
    //gets current location (coordinates) of user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        for currentLocation in locations{
            print("\(index): \(currentLocation)")
        }
    }
    
    //check if user has entered geofence
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        UserDefault.set(true, forKey: "InBounds")
    }
    
    //check if user has exited the geofence
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        UserDefault.set(false, forKey: "InBounds")
        removeSellerFromSellList()
        Utilities.showError("You have moved too far from \(campusType)")
        
    }
    
    //check if user is inside geofence when monitoring starts
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {

        switch state {
        case .inside:
            UserDefault.set(true, forKey: "InBounds")
        case .outside:
            UserDefault.set(false, forKey: "InBounds")
            removeSellerFromSellList()
        default:
            UserDefault.set(true, forKey: "InBounds")
        }
    }
    
    func addSellerToSellList(){
        
        var swipePrice: Double? = Double(enterPriceTextField.text!)

        let docRef = db.collection("users").document(userID)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let firstName = (document.get("first_name") as? String)!
                let lastName = (document.get("last_name") as? String)!
                let phoneNumber = (document.get("phone_number") as? String)!
                
                db.collection("sellers\(campus)").document(userID).setData(["first_name":firstName,"last_name":lastName,"phone_number":phoneNumber,"swipe_price":swipePrice]) { (error) in
                    
                    if error != nil {
                        
                        //go back to sell page if something fails
                        Utilities.showError("Error assigning user to sell list.")
                        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
                    } else {
                        
                        //go to searching for buyer view
                        print("Searching for buyer")
                    }
                }
            } else {
                Utilities.showError("Can not retrieve user data")
            }
        }
    }
    
    @objc func removeSellerFromSellList(){
        
        db.collection("sellers\(campus)").document(userID).delete() { err in
            if let err = err {
                Utilities.showError("Error removing user from sell list")
            } else {
                print("Success on removing the document")
            }
        }
    }
    
    func startMonitoringRegions(){
        if(campusType == "The Commons"){
            locationManager.startMonitoring(for: Utilities.getKennesawCampusCoords())
        } else if (campusType == "Stingers") {
            locationManager.startMonitoring(for: Utilities.getMariettaCampusCoords())
        } else {
            Utilities.showError("Can not find campus type. Contact support!")
        }
    }
    
    //Only allow decimal numbers in the price text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = enterPriceTextField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
                numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SFBController
        
        vc.locationData = locationManager
        vc.campusType = campusType

    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
