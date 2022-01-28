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
    
    @IBAction func resetButtonPressed(_ sender: Any)
    {
        let email = emailTextField.text!
        if Utilities.isEmailValid(email) == false{
            
            ProgressHUD.showError(emailEmpty)
            return
        } else {
            Utilities.resetPassword(email: email, onSuccess: {
                self.view.endEditing(true)
                ProgressHUD.showSuccess(self.emailSuccess)
            }) { (errorMessage) in
                ProgressHUD.showError(errorMessage)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
