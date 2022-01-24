//
//  SMSVerifyViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/23/22.
//

import UIKit
import FirebaseAuth

class SMSVerifyViewController: UIViewController {
    
    @IBOutlet weak var SMSCodeTextField: UITextField!
    
    let userDefault = UserDefaults.standard
    
    @IBAction func resendButtonPressed(_ sender: Any)
    {
        
    }

    @IBAction func confirmButtonPressed(_ sender: Any)
    {
        guard let SMSCode = SMSCodeTextField.text else { return }
        
        guard let verificationId = userDefault.string(forKey: "verificationId") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: SMSCode)
        
        Auth.auth().signInAndRetrieveData(with: credential) { success, error in
            if error == nil {
                print(success)
                print("User Signed Up")
                self.performSegue(withIdentifier: "CompletedSegue", sender: self)
            } else {
                print("Something went wrong... \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
