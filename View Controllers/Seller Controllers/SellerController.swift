//
//  SellerController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/22/22.
//

import UIKit

class SellerController: UIViewController {
    
    var diningHallType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }

    //Set diningHallType to Kennesaw Campus (important for later)
    @IBAction func theCommonsButtonPressed(_ sender: Any)
    {
        self.view.isUserInteractionEnabled = false
        
        diningHallType = "The Commons"
                
        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
        
        self.view.isUserInteractionEnabled = true
    }

    //Set diningHallType to Marietta Campus (important for later)
    @IBAction func stingersButtonPressed(_ sender: Any)
    {
        self.view.isUserInteractionEnabled = false
        
        diningHallType = "Stingers"
                
        self.performSegue(withIdentifier: "SellerCampusSegue", sender: self)
        
        self.view.isUserInteractionEnabled = true
    }
    
    //Pass on the variable to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SellerCampusController
        
        vc.campusType = diningHallType

    }
}
