//
//  SearchModels.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 25.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getTracks(searchTerm: String)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks(searchResponse: SearchResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
}

struct SearchViewModel {
    
    struct Cell: TrackCellViewModel {        
        var iconUrlString: String?
        var trackName: String
        var artistName: String
        var collectionName: String
        var previewUrl: String?
    }
    
    let cells: [Cell]
}
