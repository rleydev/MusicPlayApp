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
    
    func set(viewModel: TrackCellViewModel) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
}
