//
//  ArtDetails.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit

class ArtDetails: UIViewController {
    var artName = ""
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var artYear: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
