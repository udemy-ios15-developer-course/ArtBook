//
//  AddArt.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit
import CoreData

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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(UUID(), forKey: "id")
        newPainting.setValue(artName!.text, forKey: "name")
        newPainting.setValue(artist!.text, forKey: "artist")
        
                
        if let year = Int(artYear.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = art.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        
        do {
            try context.save()
        } catch {
            fatalError("Save failed\n\(error)")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
