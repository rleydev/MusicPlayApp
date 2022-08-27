//
//  TrackCell.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 25.08.2022.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

final class TrackCell: UITableViewCell {
    
    static let reuseId = "TrackCell"
    var cell: SearchViewModel.Cell?
    
    @IBOutlet private var trackImageView: UIImageView!
    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var collectionNameLabel: UILabel!
    @IBOutlet var addTrackButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        self.cell = viewModel
        
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavorite = savedTracks.firstIndex(where: { $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName }) != nil
        if hasFavorite {
            addTrackButton.isHidden = true
        } else {
            addTrackButton.isHidden = false
        }
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func addFavoriteTrackTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        var listOfTracks = defaults.savedTracks()
        guard let cell = cell else { return }
        
        addTrackButton.isHidden = true
        
        listOfTracks.append(cell)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false) {
            
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
            print("track added to fav sucessfully")
        }
    }
    
}
