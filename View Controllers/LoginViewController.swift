//
//  LoginViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/20/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "TabBarShow", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
