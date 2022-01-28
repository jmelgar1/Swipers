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
                        
                        ProgressHUD.showError(error!.localizedDescription)
                        
                        //1 is true 0 is false
                    } else if (isVerified! == 1){
                        
                        self.performSegue(withIdentifier: "TabBarShow", sender: self)
                        
                    } else {
                        
                        ProgressHUD.showError("Your account is not verified yet!")

                    }
                }
            } else {
                ProgressHUD.showError("Incorrect login details")
            }
        }
    }
    
    @IBAction func passwordResetPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "forgotPasswordSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
