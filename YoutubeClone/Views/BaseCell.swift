//
//  BaseCell.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 27/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
