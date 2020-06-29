//
//  Setting.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 28/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import Foundation

class Setting {
    let imageName: ImageSettingName.RawValue
    let name: SettingName.RawValue
    
    enum ImageSettingName: String {
        case settings
        case privacy
        case feedback
        case help
        case switchAccount = "switch_account"
        case cancel
    }
    
    enum SettingName: String {
        case settings = "Settings"
        case privacy = "Terms & Privacy Policy"
        case feedback = "Send Feedback"
        case help = "Help"
        case switchAccount = "Switch Account"
        case cancel = "Cancel"
    }
    
    init(imageName: ImageSettingName, name: SettingName) {
        self.imageName = imageName.rawValue
        self.name = name.rawValue
    }
}
