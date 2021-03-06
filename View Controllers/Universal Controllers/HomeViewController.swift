//
//  ViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/20/22.
//

import UIKit
import Stripe

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    //Go to login page if login button is pressed
    @IBAction func loginViewButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LoginViewShow", sender: self)
    }
    
    //Go to signup page is sign up button is pressed
    @IBAction func signupViewButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SignUpViewShow", sender: self)
    }
}

