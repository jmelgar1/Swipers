//
//  SellerMariettaController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit

class SellerMariettaController: UIViewController {

    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
    }


}
