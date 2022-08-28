//
//  ArtDetails.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit
import CoreData

class ArtDetails: UIViewController {
    var artName = ""
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var artYear: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedPainting == "" {
            return
        }
        
        let id = selectedPaintingId!.uuidString
        
    }
}
