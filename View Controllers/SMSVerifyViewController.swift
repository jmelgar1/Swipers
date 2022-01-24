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
    
    var verificationId: String = ""
    
    @IBAction func resendButtonPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any)
    {
        guard let SMSCode = SMSCodeTextField.text else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: <#T##String#>, verificationCode: <#T##String#>)
        
        Auth.auth().signInAndRetrieveData(with: <#T##FIRAuthCredential#>) { success, error in
            <#code#>
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
