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
import JGProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    /*
     //unused for now
    private let spinner = JGProgressHUD(style: .dark)
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any)
    {
        
        //Create clean versions of text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Get is_verified value from users data document from firebase
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let isVerified = document.get("is_verified") as? Int
                
                //sign in the user and check for verification
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    
                    if error != nil {
                        
                        Utilities.showError(error!.localizedDescription)
                        
                        //1 is true 0 is false
                    } else if (isVerified! == 1){
                        
                        self.performSegue(withIdentifier: "TabBarShow", sender: self)
                        
                    } else {
                        
                        Utilities.showError("Your account is not verified yet!")

                    }
                }
            } else {
                Utilities.showError("Incorrect login details")
            }
        }
    }
    
    //Go to password reset page is user clicks on forgot password
    @IBAction func passwordResetPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "forgotPasswordSegue", sender: self)
    }
}
