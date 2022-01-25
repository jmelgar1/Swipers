//
//  SMSVerifyViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/23/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SMSVerifyViewController: UIViewController {
    
    @IBOutlet weak var SMSCodeTextField: UITextField!
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    
    let userDefault = UserDefaults.standard
    
    var delegate: ErrorProtocol?
    
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
                self.delegate?.showError("Unable to get secret verification code from firebase")
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
                
                //store user data
                self.storeUserData()
                
                //Go to completed sign up page
                self.performSegue(withIdentifier: "CompletedSegue", sender: self)
            } else {
                print("Something went wrong... \(error?.localizedDescription)")
            }
        }
    }
    
    func storeUserData(){
        
        //Create the user
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, err in
            
            //Check for errors
            if err != nil {
                
                self.delegate?.showError("Error creating user")
                //There was an issue creating the user
            }
            else {
                
                //User can be created, store the data
                let db = Firestore.firestore()
                
                db.collection("users").document(result!.user.uid).setData(["first_name":self.firstName,"last_name":self.lastName,"is_verified":false,"email":email,"phone_number":phoneNumber]) { (error) in
                    
                    if error != nil {
                        self.delegate?.showError("Error saving user data")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
