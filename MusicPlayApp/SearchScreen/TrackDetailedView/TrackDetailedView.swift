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
    
    let imageScale: CGFloat = 0.8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trackImageView.transform = CGAffineTransform(scaleX: imageScale, y: imageScale)
        trackImageView.layer.cornerRadius = 5
        
    }
    
    private func monitorStartTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.enlargeTrackImageView()
        }
    }
    
    private func enlargeTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = .identity
        }, completion: nil)
    }
    
    private func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = CGAffineTransform(scaleX: self.imageScale, y: self.imageScale)
        }, completion: nil)
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
        setUpButtonsAppearance()
        monitorStartTime()
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
            enlargeTrackImageView()
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            reduceTrackImageView()
        }
    }
}
