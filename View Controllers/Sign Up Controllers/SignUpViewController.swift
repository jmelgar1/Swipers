//
//  SignUpViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit
import ProgressHUD
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phonenumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //field delegates
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        phonenumberField.delegate = self
        passwordField.delegate = self
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func validateFields() -> String? {

        //Ensure all fields are filled in
    if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phonenumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        //get cleaned strings from text fields
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phonenumber = phonenumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Ensure password is valid
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure password is at least 8 characters, contains a special character and a number!"
            
        //Ensure phone number is valid
        } else if Utilities.isPhoneNumberValid(phonenumber) == false {
            return "Please enter a valid phone number!"
            
        //Ensure email is valid
        } else if Utilities.isEmailValid(cleanedEmail) == false{
            return "Please enter a valid email!"
        }
        return nil
    }
    
    //Brings user to secord screen for signing up
    @IBAction func nextStepButtonPressed(_ sender: Any)
    {
        self.view.isUserInteractionEnabled = false
        
        let error = validateFields()

        if error != nil {
            //If something is wrong with the fields this shows up
            Utilities.showError(error!)
            self.view.isUserInteractionEnabled = true
        } else {
            self.performSegue(withIdentifier: "SignUpViewShow2", sender: self)
            self.view.isUserInteractionEnabled = true
        }
    }
    
    //pass string variables to signupviewcontroller2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SignUpViewController2
        vc.firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.phoneNumber = phonenumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        vc.password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

    }
    
    @IBAction func showPasswordSwitch(_ sender: Any)
    {
        if ((sender as AnyObject).isOn == true){
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phonenumberField.resignFirstResponder()
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
