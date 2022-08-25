//
//  AddArt.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit

class AddArt: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var artName: UITextField!
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var artYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        let gr = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        art.addGestureRecognizer(gr)
        art.isUserInteractionEnabled = true
    }
    
    @objc
    func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        // this is marked as obsolete. Should go back to figure out how to do this the new way
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        art.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    
}
