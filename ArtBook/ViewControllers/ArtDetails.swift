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
        
        let id = selectedPaintingId?.uuidString
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id=%@", id!)
        
        var results : [Any]
        
        do {
            results = try context.fetch(fetchRequest)
            if results.count == 0 {
                return
            }
        } catch {
            fatalError("Failed to get the requested item")
        }
        let resultSet = results as! [NSManagedObject]
        let result = resultSet[0]
        
        if let name = result.value(forKey: "name") as? String {
            artName = name
        }
        
        if let artist = result.value(forKey: "artist") as? String {
            self.artist.text = artist
        }
        
        if let year = result.value(forKey: "year") as? Int {
            artYear.text = String(year)
        }
        
        if let imageData = result.value(forKey: "image") as? Data {
            let image = UIImage(data: imageData)
            art.image = image
        }
    }
}

