//
//  SignUpViewController.swift
//  Swipers
//
//  Created by Josh Melgar on 1/21/22.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func nextStepButtonPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "SignUpViewShow2", sender: self)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width/2
        circularImageView.clipsToBounds = true
    }

}
