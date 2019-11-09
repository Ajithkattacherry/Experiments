//
//  FlicksViewController.swift
//  Flicks
//
//  Created by Ajith Antony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FlicksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var flicksDataModel: FlicksDataModel?
    
    // MARK: - Actions
    @IBAction func resetSearch(sender: Any) {
        flicksDataModel?.photos.removeAll(keepingCapacity: false)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
        self.title = "Image Search"
    }
    
    // MARK - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoSegue" {
            let photoViewController = segue.destination as! FlicksDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            photoViewController.flickerPhotos = flicksDataModel?.photos[selectedIndexPath!.row]
        }
    }
    
    // MARK: - Private
    private func performSearchWithText(searchText: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        FlicksNetworkManager.fetchPhotosForSearchText(searchText: searchText) { (error, flicksDataModel) in
            DispatchQueue.main.async(execute: { () -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            
            guard let dataModel = flicksDataModel else {
                if error?.code == FlicksNetworkManager.Errors.invalidAccessErrorCode {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.showErrorAlert()
                    })
                }
                return
            }
            self.flicksDataModel = dataModel
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = searchText
                self.tableView.reloadData()
            })
        }
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Search Error", message: "Invalid API Key", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FlicksViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flicksDataModel?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResultCellIdentifier = "SearchResultCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchResultCellIdentifier, for: indexPath as IndexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        cell.setupWithPhoto(flickerPhotos: flicksDataModel?.photos[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PhotoSegue", sender: self)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

extension FlicksViewController: UISearchControllerDelegate, UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearchWithText(searchText: searchBar.text!)
    }
}



