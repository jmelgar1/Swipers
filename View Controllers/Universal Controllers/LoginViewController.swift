//
//  LoginViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/20/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import ProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    /*
     //unused for now
    private let spinner = JGProgressHUD(style: .dark)
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToTabBar), name: Notification.Name.TabBar.CallTabBarSegue, object: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any)
    {
        
        //Create clean versions of text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Get is_verified value from users data document from firebase
        DatabaseManager.isVerified(email: email, password: password)
    }
    
    //Go to password reset page is user clicks on forgot password
    @IBAction func passwordResetPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "forgotPasswordSegue", sender: self)
    }
    
    @objc func goToTabBar(){
        self.performSegue(withIdentifier: "TabBarShow", sender: self)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
