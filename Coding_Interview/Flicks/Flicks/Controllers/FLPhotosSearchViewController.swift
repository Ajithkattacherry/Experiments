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
    var shouldPaginate: Bool = true
    
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
    /// Method to reset image search.
    ///
    /// This method will reset all the post state after the previous search
    @IBAction func resetSearch(sender: Any? = nil) {
        photoListDataModel?.photos.removeAll(keepingCapacity: false)
        searchBar.text = Constants.emptyString
        searchText = Constants.emptyString
        searchBar.resignFirstResponder()
        shouldPaginate = true
        tableView.reloadData()
        title = Constants.appName
    }
    
    // MARK: - Private
    /// Method to perform image search.
    ///
    /// - parameter text: search keyword
    /// - parameter page: next page number for the search request
    private func performSearch(with text: String, page: Int = 1) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        FLNetworkManager.fetchPhotosForSearchText(searchText: text, page: page) { result in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            switch result {
            case .success(let dataModel):
                if self.photoListDataModel == nil {
                    self.photoListDataModel = dataModel
                } else {
                    self.photoListDataModel?.page = dataModel.page
                    self.photoListDataModel?.photos.append(contentsOf: dataModel.photos)
                }
                
                // If the search for the keyword no more giving photos we should stop calling the api
                // Otherwise everytime when you scroll to bottom, unneccessary api call will happen
                if dataModel.photos.count == 0 {
                    self.shouldPaginate = false
                }
                
                // If the search result is empty we will show alert saying No Result Found
                guard self.photoListDataModel?.photos.count ?? 0 > 0 else {
                    DispatchQueue.main.async {
                        self.showErrorAlert(title: Constants.alertTitle, message: Constants.noResultFound)
                        self.resetSearch()
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.title = text
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error.code {
                case Errors.invalidAccessErrorCode:
                    self.showErrorAlert(title: Errors.invalidAPIKeyTitle, message: Errors.invalidAPIKey)
                case Errors.invalidURLErrorCode:
                    self.showErrorAlert(title: Constants.alertTitle, message: Errors.invalidURL)
                case Errors.operationFailedErrorCode:
                    self.showErrorAlert(title: Constants.alertTitle, message: Errors.searchOperationFailed)
                default: break
                }
            }
        }
    }
    
    /// Method to Show Alert
    ///
    /// - parameter title: Alert Title
    /// - parameter message: Alert message
    private func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: Constants.alertDismissTitle, style: .default, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
        if indexPath.row == lastRowIndex && shouldPaginate {
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
        photoListDataModel?.photos.removeAll(keepingCapacity: false)
        shouldPaginate = true
        searchText = text
        performSearch(with: text)
    }
}



