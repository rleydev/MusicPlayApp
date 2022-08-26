//
//  TrackDetailedView.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 26.08.2022.
//

import UIKit
import SDWebImage
import AVKit

final class TrackDetailedView: UIView {
    
    @IBOutlet private var trackImageView: UIImageView!
    @IBOutlet private var currentTimeSlider: UISlider!
    @IBOutlet private var currentTimeLabel: UILabel!
    @IBOutlet private var durationLabel: UILabel!
    @IBOutlet private var trackTitleLabel: UILabel!
    @IBOutlet private var authorTitleLabel: UILabel!
    @IBOutlet private var playPauseButton: UIButton!
    @IBOutlet private var volumeSlider: UISlider!
    
    @IBOutlet var previousTrackButton: UIButton!
    @IBOutlet var nextTrackButton: UIButton!
    
    let player: AVPlayer = {
        let avplayer = AVPlayer()
        avplayer.automaticallyWaitsToMinimizeStalling = false
        return avplayer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpButtonsAppearance()
       
        trackImageView.backgroundColor = .red
        
    }
    
    private func setUpButtonsAppearance() {
        previousTrackButton.setTitle(nil, for: .normal)
        nextTrackButton.setTitle(nil, for: .normal)
        playPauseButton.setTitle(nil, for: .normal)
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        trackTitleLabel.text = viewModel.trackName
        authorTitleLabel.text = viewModel.artistName
        playTrack(previewUrl: viewModel.previewUrl)
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    private func playTrack(previewUrl: String?) {
        print("trying to turn on track \(previewUrl ?? "no track")")
        
        guard let previewUrl = URL(string: previewUrl ?? "") else {
            return
        }
        let playerItem = AVPlayerItem(url: previewUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func handleCurrentTimerSlider(_ sender: Any) {
        
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
        
    }
    @IBAction func previousTrackButtonTapped(_ sender: Any) {
        
    }
    @IBAction func nextTrackButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
}
