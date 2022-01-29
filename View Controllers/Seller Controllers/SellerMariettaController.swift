//
//  SellerMariettaController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/28/22.
//

import UIKit

class SellerMariettaController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var averagePriceTextField: UITextField!
    
    @IBOutlet weak var enterPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background of text fields
        averagePriceTextField.background = UIImage(named: "priceField.png")
        
        enterPriceTextField.background = UIImage(named: "swipePriceField.png")
        
        enterPriceTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,   replacementString string: String) -> Bool {
        let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        guard !s.isEmpty else { return true }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.number(from: s)?.intValue != nil
     }
}
