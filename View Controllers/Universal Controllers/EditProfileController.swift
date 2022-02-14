//
//  EditProfileController.swift
//  Swipers
//
//  Created by Josh Melgar on 2/12/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class EditProfileController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editEmailTextField: UITextField!
    @IBOutlet weak var editPhoneNumberTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseManager.getFullName() { (fullName) in
            self.editNameTextField.placeholder = fullName
        }
        
        DatabaseManager.getEmail() { (email) in
            self.editEmailTextField.text = email
        }
        
        DatabaseManager.getPhoneNumber() { (phoneNumber) in
            self.editPhoneNumberTextField.text = phoneNumber
        }
        
        //will figure out password later
    }
}
