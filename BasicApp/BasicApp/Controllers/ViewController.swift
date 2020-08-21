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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView.estimatedRowHeight = 100
        listTableView.rowHeight = UITableView.automaticDimension
        
        NetworkManager.getList(onComplete: { (result) in
            switch result {
                case .success(let model):
                    self.model = model
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                    }
                case .failure(let error):
                    error
            }
        })
    }
    
    // MARK - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedViewSeque" {
            let detailViewController = segue.destination as! DetailViewController
            guard let selectedIndexPath = listTableView.indexPathForSelectedRow else { return }
            detailViewController.imageURL = model?.categoryItems[selectedIndexPath.row].values.imageName ?? ""
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.categoryItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(model?.categoryItems[indexPath.row])
        return cell
    }
}

