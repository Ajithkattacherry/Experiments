//
//  ViewController.swift
//  Influencer
//
//  Created by Ajith Anthony on 7/4/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addSearchBarController()
    }

    func addSearchBarController() {
        let searchbar = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchbar
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 16 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableviewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableviewCell
        tableviewCell.dateLable.text = "July 4th, 2020"
        tableviewCell.myDescription.text = "Use tools to explore by time and color, zoom to view artworks in amazing detail, tour famous sites and landmarks, and more..."
        return tableviewCell
    }
    
}

