//
//  ViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Go to login page if login button is pressed
    @IBAction func loginViewButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LoginViewShow", sender: self)
    }
    
    //Go to signup page is sign up button is pressed
    @IBAction func signupViewButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SignUpViewShow", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

