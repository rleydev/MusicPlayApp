//
//  TrackDetailedView.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 26.08.2022.
//

import UIKit

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
    }
    
}
