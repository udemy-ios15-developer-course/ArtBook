//
//  ViewController.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit

class MainView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var artList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        artList.dataSource = self
        artList.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    
    @objc
    private func addButtonClicked() {
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }
}
