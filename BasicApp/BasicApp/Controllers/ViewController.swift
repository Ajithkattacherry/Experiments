//
//  ViewController.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var listTableView: UITableView!
    
    var model: DataModel?
    var filteredCategoryItems: [ListDataModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView.estimatedRowHeight = 100
        listTableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getList()
        setUpSearchBar()
    }
    
    // MARK - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailedViewSeque" {
//            let detailViewController = segue.destination as! DetailViewController
//            guard let selectedIndexPath = listTableView.indexPathForSelectedRow else { return }
//            detailViewController.imageURL = model?.categoryItems[selectedIndexPath.row].values.imageName ?? ""
//            detailViewController.delegate = self
//        }
    }
    
    func getList() {
        NetworkManager.getList(onComplete: { (result) in
            switch result {
                case .success(let model):
                    self.model = model
                    self.filteredCategoryItems = model.categoryItems
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        })
    }
    
    func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search List"
        definesPresentationContext = true
        
        // UISearchResultsUpdating
        searchController.searchResultsUpdater = self
        
        // UITextFieldDelegate
        searchController.searchBar.searchTextField.delegate = self
        
        // UISearchBarDelegate for Scope bar
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["Food", "Other"]
        searchController.searchBar.showsScopeBar = true
        
        // Search Tokens
        let purchasesToken = UISearchToken(icon: UIImage(systemName: "tag"), text: "Purchases")
        let countryToken = UISearchToken(icon: UIImage(systemName: "flag"), text: "Country")
        searchController.searchBar.searchTextField.insertToken(purchasesToken, at: 0)
        searchController.searchBar.searchTextField.insertToken(countryToken, at: 0)
        
        navigationItem.searchController = searchController
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCategoryItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(filteredCategoryItems?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewControllerStoryBoard") as? DetailViewController
        detailedViewController?.imageURL = filteredCategoryItems?[indexPath.row].values.imageName ?? ""
        detailedViewController?.delegate = self
        navigationController?.pushViewController(detailedViewController!, animated: true)
        //present(detailedViewController!, animated: true, completion: nil)
    }
}

extension ViewController: SampleProtocol {
    func testMemoryLeak() {
        print("Test My Leak")
    }
}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    defer {
        listTableView.reloadData()
        print(searchBar.text!)
    }
    let searchBar = searchController.searchBar
    guard let text = searchBar.text, !text.isEmpty else {
        filteredCategoryItems = model?.categoryItems
        return
    }
    filteredCategoryItems = model?.categoryItems.filter {
        $0.title.contains(searchBar.text!)
    }
  }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}


