//
//  SearchView.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 24.08.2022.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchView: UITableViewController {
    
    private var timer: Timer?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    private func setUpSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "mock_image")
        
        return cell
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            let url = "https://itunes.apple.com/search"
            let param = ["term": searchText, "limit": "10"]
            
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
                
                if let error = dataResponse.error {
                    print("error recieved requesting data \(error.localizedDescription)")
                    return
                }
                
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    print("objects: \(objects)")
                    
                    self.tracks = objects.results
                    self.tableView.reloadData()
                    
                } catch let jsonError {
                    print("failed to decode json \(jsonError)")
                }
                
//                let someString = String(data: data, encoding: .utf8)
//
//                print(someString ?? "")
            }
        })
    }
}
