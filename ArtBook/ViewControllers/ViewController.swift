//
//  ViewController.swift
//  ArtBook
//
//  Created by Chris Hand on 8/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var artList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc
    private func addButtonClicked() {
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }
}

