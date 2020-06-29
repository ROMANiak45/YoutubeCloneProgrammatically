//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 26/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit
import SDWebImage

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            if let thumbnailImageName = video?.thumbNailImageName {
                thumbnailImageView.sd_setImage(with: URL(string: thumbnailImageName))
            }
            if let profileImageName = video?.channelName?.profileImageName {
                userProfileImageView.sd_setImage(with: URL(string: profileImageName))
            }
            titleLabel.text = video?.title
            if let channelName = video?.channelName?.name, let numberOfViews = video?.numberOfViews {
                subtitleTextView.text = "\(channelName) • \(numberOfViews.withCommas()) • 2 years ago"
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stiker")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rick")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.text = "Youtube Clone Video Blank Space some more title text here on the second line"
        label.numberOfLines = 2
        return label
    }()
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .darkGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .white
        return textView
    }()
    
    override func setupViews() {
        backgroundColor = .darkGray
        
        let imageSize = self.frame.size.width / 7
        userProfileImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        userProfileImageView.layer.cornerRadius = imageSize / 2
        
        [thumbnailImageView, userProfileImageView, titleLabel, subtitleTextView].forEach { addSubview($0) }
        
        thumbnailImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: userProfileImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 12, right: 0))
        userProfileImageView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 16, right: 0))
        titleLabel.anchor(top: thumbnailImageView.bottomAnchor, leading: userProfileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 8, bottom: 14, right: 16))
        subtitleTextView.anchor(top: titleLabel.bottomAnchor, leading: userProfileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 8, bottom: 0, right: 16))
    }
}
