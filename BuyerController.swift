//
//  BuyerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit

class BuyerController: UIViewController {

    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "BuyerKennesawSegue", sender: self)
    }
    
    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "BuyerMariettaSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
