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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        artList.dataSource = self
        artList.delegate = self
        getData()
    }
    
    func getData() {
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    
    @objc
    private func addButtonClicked() {
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }
}
