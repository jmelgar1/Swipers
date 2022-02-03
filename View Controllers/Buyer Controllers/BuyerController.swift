//
//  BuyerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit

class BuyerController: UIViewController {
    
    var diningHallType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        diningHallType = "The Commons"
        
        self.performSegue(withIdentifier: "BuyerSearchSegue", sender: self)
    }
    
    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        diningHallType = "Stingers"
        
        self.performSegue(withIdentifier: "BuyerSearchSegue", sender: self)
    }
    
    //Pass on the variable to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SFSController
        
        vc.campusType = diningHallType

    }
}
