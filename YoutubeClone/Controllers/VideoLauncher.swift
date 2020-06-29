//
//  VideoLauncher.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 29/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
    
    var homeController: HomeController?
    var exploreController: ExploreController?
    var subscriptionsController: SubscriptionsController?
    var inboxController: InboxController?
    var accountController: AccountController?
    
    var backgroundView: UIView?
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            backgroundView = UIView(frame: keyWindow.frame)
            backgroundView?.backgroundColor = .white
            
            backgroundView?.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: keyWindow.safeAreaInsets.top, width: keyWindow.frame.width, height: height))
            backgroundView?.addSubview(videoPlayerView)
            
            if let view = backgroundView {
                keyWindow.addSubview(view)
            }
            
            let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
            slideDown.direction = .down
            backgroundView?.addGestureRecognizer(slideDown)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
                self.backgroundView?.frame = keyWindow.frame
            })
        }
    }
    
    @objc private func handleDismiss() {
        dismissWithAnimation()
    }
    
    fileprivate func dismissWithAnimation(_ indexPath: IndexPath? = nil) {
        if let height = UIApplication.shared.keyWindow?.frame.height, let width = UIApplication.shared.keyWindow?.frame.width {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
                self.backgroundView?.frame = CGRect(x: width, y: height, width: width, height: height)
            }) { [unowned self] _ in
                self.backgroundView?.subviews.forEach { $0.removeFromSuperview() }
                self.backgroundView?.removeFromSuperview()
            }
        }
        
    }
}
