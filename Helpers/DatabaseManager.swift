//
//  DatabaseManager.swift
//  Swipers
//
//  Created by Josh Melgar on 2/13/22.
//

import FirebaseAuth
import FirebaseFirestore

class DatabaseManager {
    
    static var sharedSessionManager = DatabaseManager()
    
    static func getFirstName(completion: @escaping(String)->()){
        var firstName: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                firstName = (document.get("first_name") as? String)!
                completion(firstName)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
    
    static func getLastName(completion: @escaping(String)->()){
        var lastName: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                lastName = (document.get("last_name") as? String)!
                completion(lastName)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
    
    static func getFullName(completion: @escaping(String)->()){
        var firstName: String = ""
        var lastName: String = ""
        var fullName: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                firstName = (document.get("first_name") as? String)!
                lastName = (document.get("last_name") as? String)!
                fullName = "\(firstName) \(lastName)"
                completion(fullName)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
    
    static func getEmail(completion: @escaping(String)->()){
        var email: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                email = (document.get("email") as? String)!
                completion(email)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
    
    static func getPhoneNumber(completion: @escaping(String)->()){
        var phoneNumber: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                phoneNumber = (document.get("phone_number") as? String)!
                completion(phoneNumber)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
    
    static func isVerified(email: String, password: String){
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let isVerified = document.get("is_verified") as? Int
                
                //sign in the user and check for verification
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    
                    if error != nil {
                        
                        Utilities.showError(error!.localizedDescription)
                        
                        //1 is true 0 is false
                    } else if (isVerified! == 1){
                        
                        NotificationCenter.default.post(name: Notification.Name.TabBar.CallTabBarSegue, object: nil)
                        
                    } else {
                        
                        Utilities.showError("Your account is not verified yet!")

                    }
                }
            } else {
                Utilities.showError("Incorrect login details")
            }
        }
    }
}

extension Notification.Name {
    struct TabBar {
        static let CallTabBarSegue = Notification.Name("CallTabBarSegue")
    }
}
