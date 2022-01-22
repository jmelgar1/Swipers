//
//  SignUpViewController2.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit

class SignUpViewController2: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var button: UIButton?
    
    //camera talon card picture function here

    @IBAction func submitButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "SignUpCompletedShow", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapTakePhoto(){
        
    }


}
