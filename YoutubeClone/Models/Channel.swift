//
//  Channel.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 27/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

struct Channel: Decodable {
    var name: String?
    var profileImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}
