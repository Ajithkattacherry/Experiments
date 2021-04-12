//
//  StoreListViewModel.swift
//  StoreSearch
//
//  Created by Ajith Anthony on 9/21/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum StoreListDataProviderError: Error {
    case invalidDataResponse
    case otherError(error: Error)
}

class StoreListDataProvider {
    
    private let networkManager: NetworkManagerProtocl?
    
    init(networkManager: NetworkManagerProtocl = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadStoreList(from text: String, completion: @escaping (Result<[StoreListViewModel], StoreListDataProviderError>) -> Void) {
        let url = Contants.baseURL + Contants.query + "\(text)" + Contants.otherParams
        networkManager?.getStoreList(from: url) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                guard let model = self.getViewModel(from: list) else {
                    return completion(.failure(.invalidDataResponse))
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(.otherError(error: error)))
            }
        }
    }
    
    private func getViewModel(from dataModel: StoreListDataModel) -> [StoreListViewModel]? {
        var viewModel = [StoreListViewModel]()
        for list in dataModel.results {
            viewModel.append(StoreListViewModel(from: list))
        }
        return viewModel
    }
}

struct StoreListViewModel {
    var name: String
    
    init(from storeList: StoreList) {
        name = storeList.name
    }
}
