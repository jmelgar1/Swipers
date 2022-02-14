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
    
    static func isVerified(completion: @escaping(Int)->()){
        var isVerified: Int = 0
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                isVerified = (document.get("is_verified") as? Int)!
                completion(isVerified)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }
}
