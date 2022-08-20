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
    }
    
    @IBAction func saveClicked(_ sender: Any) {
    }
}
