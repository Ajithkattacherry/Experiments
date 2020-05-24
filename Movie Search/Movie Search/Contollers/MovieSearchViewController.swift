//
//  SearchViewController.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let sessionManager = MovieSearchSessionManager()
    private var searchResults: [MovieSearchDataModel]?
    private var workItemDataLoad: DispatchWorkItem?
    
    var updatingView = LoadingView(text: Constants.infoDownloading)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        //Updating View set
        updatingView.addToView(aView: view)
        updatingView.center = CGPoint(x: view.frame.size.width/2,
                                      y: view.frame.size.height/2)
        
        //Set Background color to white
        view.backgroundColor = .white
        
        //Set Search Controller on naviagtion bar
        navigationItem.searchController = searchController
        self.tableView.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil),
                                forCellReuseIdentifier: Constants.movieCellId)
        //Set all delegates
        searchController.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("NewString: \(searchText)")
        workItemDataLoad?.cancel()
        
        DispatchQueue.main.async {
            self.updatingView.show(show: true)
        }
        workItemDataLoad = DispatchWorkItem {
            self.sessionManager.movieSerchSessionCall(searchText: searchText) { movieData in
                DispatchQueue.main.async {
                    self.searchResults = movieData
                    self.updatingView.show(show: false)
                    self.tableView.reloadData()
                }
            }
        }
        //workItemDataLoad?.perform()
        DispatchQueue.global().async(execute: workItemDataLoad!)
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = searchResults else { return 0 }
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellId) as? MovieSearchTableViewCell,
            let results = searchResults
            else { return UITableViewCell() }
        
        if  let posterData = results[indexPath.row].posterData,
            let poster = UIImage(data:posterData) {
            cell.set(title: results[indexPath.row].title,
                     subtitle: results[indexPath.row].overview,
                     poster: poster)
        } else {
            cell.set(title: results[indexPath.row].title,
                     subtitle: results[indexPath.row].overview,
                     poster: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

