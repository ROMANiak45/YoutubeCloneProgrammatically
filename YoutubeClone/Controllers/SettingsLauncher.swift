//
//  SettingsLauncher.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 28/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    var homeController: HomeController?
    var exploreController: ExploreController?
    var subscriptionsController: SubscriptionsController?
    var inboxController: InboxController?
    var accountController: AccountController?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let blackView = UIView()
    
    private let settings: [Setting] = {
        return [
            Setting(imageName: .settings, name: .settings),
            Setting(imageName: .privacy, name: .privacy),
            Setting(imageName: .feedback, name: .feedback),
            Setting(imageName: .help, name: .help),
            Setting(imageName: .switchAccount, name: .switchAccount),
            Setting(imageName: .cancel, name: .cancel)
        ]
    }()
    
    func showSettings() {
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.fillSuperview()
            collectionView.frame = CGRect(x: window.frame.width, y: 0, width: window.frame.width * 0.75, height: window.frame.height)
            
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
                self.blackView.alpha = 1
                self.collectionView.alpha = 1
                
                self.collectionView.frame = CGRect(x: window.frame.width / 4, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            })
        }
    }
    
    @objc private func handleDismiss() {
        dismissWithAnimation()
    }
    
    fileprivate func dismissWithAnimation(_ indexPath: IndexPath? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.blackView.alpha = 0
            
            self.collectionView.frame = CGRect(x: self.blackView.frame.width, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }) { [unowned self] _ in
            self.blackView.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            self.collectionView.removeFromSuperview()
            self.blackView.removeFromSuperview()
            if let index = indexPath?.item {
                let setting = self.settings[index]
                if setting.name != "Cancel" {
                    self.homeController?.showSettingMenuController(withTitle: setting.name)
                }
            }
        }
    }
    
    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "cellId")
    }
}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismissWithAnimation(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
