//
//  Video.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 27/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

struct Video: Decodable {
    var thumbNailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?
    var channelName: Channel?
    
    enum CodingKeys: String, CodingKey {
        case thumbNailImageName = "thumbnail_image_name"
        case title
        case numberOfViews = "number_of_views"
        case uploadDate
        case channelName = "channel"
    }
}
