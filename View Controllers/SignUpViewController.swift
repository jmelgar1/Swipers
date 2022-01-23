//
//  SignUpViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ErrorProtocol {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phonenumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width/2
        circularImageView.clipsToBounds = true
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        phonenumberField.delegate = self
        passwordField.delegate = self
    }
    
    func validateFields() -> String? {
    
    if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phonenumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
        
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure password is at least 8 characters, contains a special character and a number!"
        }
        
        return nil
    }
    
    //Brings user to secord screen for signing up
    @IBAction func nextStepButtonPressed(_ sender: Any)
    {
        
        let error = validateFields()
        
        if error != nil {
            
            //If something is wrong with the fields this shows up
            showError(error!)
        }
        else {
            self.performSegue(withIdentifier: "SignUpViewShow2", sender: self)
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    //allow signupviewcontroller2 to access textfield variables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SignUpViewController2
        vc.firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.phoneNumber = phonenumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phonenumberField.resignFirstResponder()
    }
    
    //Makes the users avatar appear circular
    @IBOutlet weak var circularImageView: UIImageView!
    
    @IBAction func importImage(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After completed
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            circularImageView.image = image
        }
        else
        {
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol ErrorProtocol {
    func showError(_ message:String)
}
