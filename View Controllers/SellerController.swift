//
//  SellerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit

class SellerController: UIViewController {

    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "SellerKennesawSegue", sender: self)
    }
    
    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "SellerKennesawSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
