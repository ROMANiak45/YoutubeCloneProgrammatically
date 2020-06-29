//
//  VideoPlayerView.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 29/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        return indicator
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePausePlay), for: .touchUpInside)
        return button
    }()
    
    let controllsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    var player: AVPlayer?
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
    }
    
    fileprivate func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/tindercloneroman.appspot.com/o/Despicable%20Me%203%20Song%20-%20BAD%20-%20Minions%20Michael%20Jackson.mp4?alt=media&token=e8c3ab31-5c4a-4590-ad38-6075aa348806"
        backgroundColor = .black
        
        let height = self.frame.width * 9 / 16
        let frameRect = CGRect(x: 0, y: self.safeAreaInsets.top, width: self.frame.width, height: height)
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = frameRect
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] progressTime in
                let seconds = CMTimeGetSeconds(progressTime)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                self?.currentTimeLabel.text = "\(minutesText):\(secondsText)"
                if let duration = self?.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self?.videoSlider.value =  Float(seconds / durationSeconds)
                }
            })
            
            controllsContainerView.frame = frameRect
            addSubview(controllsContainerView)
            
            [activityIndicatorView, pausePlayButton, videoLengthLabel, currentTimeLabel, videoSlider].forEach { controllsContainerView.addSubview($0) }
            activityIndicatorView.centerInSuperview()
            pausePlayButton.centerInSuperview()
            videoLengthLabel.anchor(top: nil, leading: nil, bottom: controllsContainerView.bottomAnchor, trailing: controllsContainerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 3, right: 8), size: .init(width: 45, height: 24))
            currentTimeLabel.anchor(top: nil, leading: controllsContainerView.leadingAnchor, bottom: controllsContainerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 3, right: 0), size: .init(width: 45, height: 24))
            videoSlider.anchor(top: nil, leading: currentTimeLabel.trailingAnchor, bottom: controllsContainerView.bottomAnchor, trailing: videoLengthLabel.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controllsContainerView.backgroundColor = .clear
            
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
            
        }
    }
    
    @objc fileprivate func handlePausePlay() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc fileprivate func handleSlider() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { completion in
                
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
