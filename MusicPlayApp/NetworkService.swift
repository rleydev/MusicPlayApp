//
//  NetworkService.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 25.08.2022.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let param = ["term": searchText, "limit": "10", "media": "music"]
        
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            
            if let error = dataResponse.error {
                print("error recieved requesting data \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects: \(objects)")
                completion(objects)
            } catch let jsonError {
                print("failed to decode json \(jsonError)")
                completion(nil)
            }
            
//            let someString = String(data: data, encoding: .utf8)
//
//            print(someString ?? "")
        }
    }
}
