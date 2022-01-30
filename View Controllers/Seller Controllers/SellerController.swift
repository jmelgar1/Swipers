//
//  SellerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit

class SellerController: UIViewController {
    
    var diningHallType: String = ""

    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        diningHallType = "The Commons"
                
        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
    }

    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        diningHallType = "Stingers"
                
        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SellerCampusController
        
        vc.campusType = diningHallType

    }
}
