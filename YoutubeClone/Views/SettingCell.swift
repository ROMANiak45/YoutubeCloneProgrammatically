//
//  SettingCell.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 28/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    var setting: Setting? {
        didSet {
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .white
            }
            nameLabel.text = setting?.name
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .darkGray
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        [iconImageView, nameLabel].forEach { addSubview($0) }
        iconImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 8, left: 16, bottom: 8, right: 0), size: .init(width: frame.height - 16, height: 0))
        nameLabel.anchor(top: topAnchor, leading: iconImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
}
