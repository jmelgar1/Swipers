//
//  ForgotPasswordViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/24/22.
//

import UIKit
import ProgressHUD

class ForgotPasswordViewController: UIViewController {

    let emailSuccess = "We have sent you a password reset email. Please check your inbox and follow the instructions to reset your password"
    
    let emailEmpty = "Please enter a valid email"
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any)
    {
        let email = emailTextField.text!
        if Utilities.isEmailValid(email) == false{
            
            Utilities.showError(emailEmpty)
            return
        } else {
            Utilities.resetPassword(email: email, onSuccess: {
                self.view.endEditing(true)
                Utilities.showSuccess(self.emailSuccess)
            }) { (errorMessage) in
                Utilities.showError(errorMessage)
            }
        }
    }
}
