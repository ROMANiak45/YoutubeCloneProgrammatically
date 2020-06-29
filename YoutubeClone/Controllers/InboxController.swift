//
//  InboxController.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 29/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class InboxController: UIViewController {
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.inboxController = self
        return launcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let label = UILabel()
        label.text = "You have no messages."
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        view.addSubview(label)
        label.centerInSuperview()
        
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Inbox"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc fileprivate func handleSearch() {
        let alert = UIAlertController(title: "Searching...", message: "Search button was pressed...", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertButton)
        self.show(alert, sender: self)
    }
    
    @objc fileprivate func handleMore() {
        settingsLauncher.showSettings()
    }
}
