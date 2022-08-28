//
//  ViewController.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit
import CoreData

class MainView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var artList: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        artList.dataSource = self
        artList.delegate = self
        getData()
    }
    
    @objc
    func getData() {
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequesst = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequesst.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequesst)
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
            }
        } catch {
            fatalError("Failed to read data\n\(error)")
        }
        
        self.artList.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPainting"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtDetails" {
            let destination = segue.destination as! ArtDetails
            destination.selectedPainting = selectedPainting
            destination.selectedPaintingId = selectedPaintingId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toArtDetails", sender: nil)
    }
        
    @objc
    private func addButtonClicked() {
        selectedPainting = ""
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "id=%@", idArray[indexPath.row].uuidString)
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count == 0 {
                    return
                }
                
                let resultObjects = results as! [NSManagedObject]
                let result = resultObjects[0]
                context.delete(result)
                try context.save()
                nameArray.remove(at: indexPath.row)
                idArray.remove(at: indexPath.row)
                self.artList.reloadData()
            } catch {
                fatalError("failed to get item")
            }
        }
    }
}
