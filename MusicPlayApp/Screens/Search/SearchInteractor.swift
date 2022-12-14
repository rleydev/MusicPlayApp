//
//  SearchInteractor.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

final class SearchInteractor: SearchBusinessLogic {
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    var networkService = NetworkService()
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks(let searchTerm):
            print("interactor get tracks")
            
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
            
            networkService.fetchTracks(searchText: searchTerm, completion: { [weak self] searchResponse in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: searchResponse))
            })
        }
    }
    
}
