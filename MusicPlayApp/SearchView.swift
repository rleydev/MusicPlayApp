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
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tracks = [TrackModel(trackName: "some", artistName: "Alen"), TrackModel(trackName: "any", artistName: "Dem")]
    
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
        
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(url).responseData { dataResponse in
            if let error = dataResponse.error {
                print("error ercieved requesting data \(error.localizedDescription)")
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let someString = String(data: data, encoding: .utf8)
            
            print(someString ?? "")
        }
    }
}
