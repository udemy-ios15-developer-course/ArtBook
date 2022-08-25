//
//  AddArt.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit

class AddArt: UIViewController {

    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var artName: UITextField!
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var artYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    
}
