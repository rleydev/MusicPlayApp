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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        self.cell = viewModel
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func addFavoriteTrackTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            
            defaults.set(savedData, forKey: "myTracks")
            print("track added to fav sucessfully")
        }
    }
    
}
