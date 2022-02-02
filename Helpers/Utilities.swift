//
//  Utilities.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class Utilities {
    
    //checks if users password is valid
    static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //checks if users email is valid
    static func isEmailValid(_ email : String) -> Bool{
        let emailTest = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailTest)
        return emailPred.evaluate(with: email)
    }
    
    //checks if users phone number is valid
    static func isPhoneNumberValid(_ phonenumber: String) -> Bool {
        let PHONE_REGEX = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluate(with: phonenumber)
    }
    
    //sends email if user forgets password
    static func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    //gets latitude/longitude for the commons (kennesaw campus)
    static func getKennesawCampusCoords() -> CLCircularRegion {
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 34.039902, longitude: -84.581810), radius: 400, identifier: "The Commons")
        return geoFenceRegion
    }
    
    //gets latitude/longitude for stingers (marietta campus)
    static func getMariettaCampusCoords() -> CLCircularRegion {
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 33.937379, longitude: -84.522307), radius: 400, identifier: "Stingers")
        return geoFenceRegion
    }
}
