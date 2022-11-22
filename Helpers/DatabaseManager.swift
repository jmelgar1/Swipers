//
//  DatabaseManager.swift
//  Swipers
//
//  Created by Josh Melgar on 2/13/22.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Kingfisher
import UIKit

class DatabaseManager {
    
    static var sharedSessionManager = DatabaseManager()
    
    //MARK: Get Attributes
    
    //Get current user first name
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
    
    //Get current user last name
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
    
    //Get current user full name
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
    
    //Get current user email
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
    
    //Get current user phone number
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
    
    //Get current user avatar
    static func getUserAvatar(profileImage: UIImageView){
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                  return
        }
        
        profileImage.kf.setImage(with: url)
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                profileImage.image = image
            }
        })
        
        task.resume()
        
        DatabaseManager.getEmail() { (email)
            in
            let userEmail = email
            let db = Firestore.firestore()
            
            db.collection("users")
                .whereField("email", isEqualTo: userEmail)
                .getDocuments() { (querySnapshot, err) in
                    if err != nil {
                        Utilities.showError("Error finding user")
                    } else if querySnapshot!.documents.count != 1 {
                        // Perhaps this is an error for you?
                    } else {
                        let document = querySnapshot!.documents.first
                        document!.reference.updateData([
                            "image_url": urlString
                    ])
                }
            }
        }
    }
    
    //Gets other user's avatar by url string
    static func getOtherUserAvatarURLString(otherUserId: String?, completion: @escaping(String)->()){
        var urlString: String = ""
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(otherUserId!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                urlString = (document.get("image_url") as? String)!
                completion(urlString)
            } else {
                Utilities.showError("Can not find user document")
            }
        }
    }

    //Get users avatar from URL String
    static func getUserAvatarFromURLString(imageURL: String?, completion: @escaping(UIImage)->()){
        guard let urlString = imageURL,
              let url = URL(string: urlString) else {
                  return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image!)
            }
        })
        
        task.resume()
    }
    
    //MARK: Change attributes
    //Change user email
    static func changeEmail(newEmail: String){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.setData(["email" : newEmail], merge: true)
    }
    
    //Change user phone number
    static func changePhoneNumber(newPhoneNumber: String){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.setData(["phone_number" : newPhoneNumber], merge: true)
    }
    
    //MARK: Misc
    //Check is current user is verified
    static func isVerified(email: String, password: String, viewController: UIViewController){
        
        viewController.view.isUserInteractionEnabled = false
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let isVerified = document.get("is_verified") as? Int
                
                //sign in the user and check for verification
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    
                    if error != nil {
                        
                        Utilities.showError(error!.localizedDescription)
                        viewController.view.isUserInteractionEnabled = true
                        
                        //1 is true 0 is false
                    } else if (isVerified! == 1){
                        
                        NotificationCenter.default.post(name: Notification.Name.TabBar.CallTabBarSegue, object: nil)
                        
                    } else {
                        
                        Utilities.showError("Your account is not verified yet!")
                        viewController.view.isUserInteractionEnabled = true

                    }
                }
            } else {
                Utilities.showError("Incorrect login details")
                viewController.view.isUserInteractionEnabled = true
            }
        }
    }
    
    //change payment method balues
    static func changePaymentMethod(paymentMethod: String, newValue: Bool) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.setData([paymentMethod : newValue], merge: true)
    }
    
    //get used payment methods
    static func checkForPaymentMethod(paymentMethod: String, completion: @escaping (Bool)->Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let enabled = (document.get(paymentMethod) as? Bool)!
                completion(enabled)
            } else {
                completion(false)
            }
        }
    }
}
