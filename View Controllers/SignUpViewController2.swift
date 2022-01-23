//
//  SignUpViewController2.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore

class SignUpViewController2: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var button: UIButton?
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    
    var delegate: ErrorProtocol?
    
    //camera talon card picture function here

    @IBAction func submitButtonPressed(_ sender: Any)
    {
        
        //Create the user
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            //Check for errors
            if let err = err {
                //There was an issue creating the user
                self.delegate?.showError("Error creating user")
            }
            else {
                //User can be created, store the data
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["first_name":self.firstName,"last_name":self.lastName, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil {
                        self.delegate?.showError("Error saving user data")
                    }
                }
                
                self.performSegue(withIdentifier: "SignUpCompletedShow", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapTakePhoto(){
        
    }


}
