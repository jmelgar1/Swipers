//
//  SellerKennesawController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit

class SellerKennesawController: UIViewController {

    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    //go to finding buyer screen when start selling button pressed
    @IBAction func startSellingPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "KennesawLFSSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
    }


}
