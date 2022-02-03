//
//  SMSVerifyViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/23/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import ProgressHUD

class SMSVerifyViewController: UIViewController {
    
    @IBOutlet weak var SMSCodeTextField: UITextField!
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    
    let userDefault = UserDefaults.standard
    
    @IBAction func resendButtonPressed(_ sender: Any)
    {
        //send SMS code to user again
        PhoneAuthProvider.provider().verifyPhoneNumber("+1\(phoneNumber)", uiDelegate: nil) { verificationId, error in
            if error == nil {
                
                print(verificationId)
                guard let verifyId = verificationId else { return }
                self.userDefault.set(verifyId, forKey: "verificationId")
                self.userDefault.synchronize()
                
            } else {
                Utilities.showError("Unable to get secret verification code from firebase")
            }
        }
    }

    @IBAction func confirmButtonPressed(_ sender: Any)
    {
        guard let SMSCode = SMSCodeTextField.text else { return }
        
        guard let verificationId = userDefault.string(forKey: "verificationId") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: SMSCode)
        
        Auth.auth().signInAndRetrieveData(with: credential) { success, error in
            if error == nil {
                
                //store user data and determine which view to go to
                self.storeUserData()
                
            } else {
                print("Something went wrong... \(error?.localizedDescription)")
            }
        }
    }
    
    //Stores all user info in Google firebase
    func storeUserData(){
        
        //Create the user
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, err in
            
            //Check for errors
            if err != nil {
                
                Utilities.showError("Error creating user")
                //There was an issue creating the user
            }
            else {
                
                //User can be created, store the data
                let db = Firestore.firestore()
                
                db.collection("users").document(result!.user.uid).setData(["first_name":self.firstName,"last_name":self.lastName,"is_verified":false,"email":email,"phone_number":phoneNumber]) { (error) in
                    
                    if error != nil {
                        
                        //go back to login page if user data is already stored
                        Utilities.showError("Error saving user data")
                        self.performSegue(withIdentifier: "userAlreadyCreatedSegue", sender: self)
                    } else {
                        
                        //go to signup completed page
                        self.performSegue(withIdentifier: "CompletedSegue", sender: self)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
