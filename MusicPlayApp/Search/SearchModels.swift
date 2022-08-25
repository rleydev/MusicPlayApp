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
                case getTracks
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks
            }
        }
    }
    
}
