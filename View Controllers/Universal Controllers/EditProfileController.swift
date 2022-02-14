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
import FirebaseStorage

class EditProfileController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private let storage = Storage.storage().reference()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editEmailTextField: UITextField!
    @IBOutlet weak var editPhoneNumberTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                  return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profileImage.image = image
            }
        })
        
        task.resume()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    override func viewWillLayoutSubviews() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true){
            //after completed
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profileImage.image = image
            
            guard let imageData = image.pngData() else {
                return
            }
            
            let userID = Auth.auth().currentUser?.uid
            
            //images/useruid to save image
            storage.child("profilePictures/\(userID!).png").putData(imageData, metadata: nil) { _, error in
                guard error == nil else {
                    Utilities.showError("Failed to upload photos to database")
                    return
                }
                
                self.storage.child("profilePictures/\(userID!).png").downloadURL(completion: { url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("Download URL: \(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                })
            }
        }
        else
        {
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
