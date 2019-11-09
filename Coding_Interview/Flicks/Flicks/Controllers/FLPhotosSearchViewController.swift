//
//  FLPhotosSearchViewController.swift
//  Flicks
//
//  Created by Ajith Antony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FLPhotosSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photoListDataModel: FLPhotoListDataModel?
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        searchBar.placeholder = Constants.searchBarPlaceholderText
    }
    
    // MARK - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.photoDetailsSegue {
            let photoViewController = segue.destination as! FLPhotosDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            photoViewController.photoDataModel = photoListDataModel?.photos[selectedIndexPath!.row]
        }
    }
    
    // MARK: - Actions
    @IBAction func resetSearch(sender: Any) {
        photoListDataModel?.photos.removeAll(keepingCapacity: false)
        searchBar.text = Constants.emptyString
        searchBar.resignFirstResponder()
        tableView.reloadData()
        self.title = Constants.appName
    }
    
    // MARK: - Private
    private func performSearch(with text: String, page: Int = 1) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        FLNetworkManager.fetchPhotosForSearchText(searchText: text, page: page) { (error, photoListDataModel) in
            DispatchQueue.main.async(execute: { () -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            
            guard let dataModel = photoListDataModel else {
                if error?.code == Errors.invalidAccessErrorCode {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.showErrorAlert(title: Errors.invalidAPIKeyTitle, message: Errors.invalidAPIKey)
                    })
                }
                return
            }
            if self.photoListDataModel == nil {
              self.photoListDataModel = dataModel
            } else {
                self.photoListDataModel?.page = dataModel.page
                self.photoListDataModel?.photos.append(contentsOf: dataModel.photos)
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = text
                self.tableView.reloadData()
            })
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: Constants.alertDismissTitle, style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FLPhotosSearchViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoListDataModel?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchResultCellIdentifier, for: indexPath as IndexPath) as? FLSearchResultCell else {
            return UITableViewCell()
        }
        cell.setupWithPhoto(photoDataModel: photoListDataModel?.photos[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.photoDetailsSegue, sender: self)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            performSearch(with: searchText ?? "", page: (photoListDataModel?.page ?? 0) + 1)
        }
    }
}

extension FLPhotosSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {
            showErrorAlert(title: Constants.alertTitle, message: Errors.emptySearchString)
            return
        }
        searchText = text
        performSearch(with: text)
    }
}



