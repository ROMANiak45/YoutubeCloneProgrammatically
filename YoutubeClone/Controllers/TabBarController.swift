//
//  TabBarController.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 29/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    enum BottomMenuNames: String {
        case Home, Explore, Subscriptions, Inbox, Account
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }

    fileprivate func setupTabbar() {
        let layout = UICollectionViewFlowLayout()
        
        let homeController = HomeController(collectionViewLayout: layout)
        let exploreController = ExploreController(collectionViewLayout: layout)
        let subscriptionsController = SubscriptionsController(collectionViewLayout: layout)
        let inboxController = InboxController()
        let accountController = AccountController()
        
        let homeIcon = UITabBarItem(title: BottomMenuNames.Home.rawValue, image: UIImage(named: BottomMenuNames.Home.rawValue), selectedImage: UIImage(named: BottomMenuNames.Home.rawValue)?.withRenderingMode(.alwaysOriginal))
        let exploreIcon = UITabBarItem(title: BottomMenuNames.Explore.rawValue, image: UIImage(named: BottomMenuNames.Explore.rawValue), selectedImage: UIImage(named: BottomMenuNames.Explore.rawValue)?.withRenderingMode(.alwaysOriginal))
        let subscriptionsIcon = UITabBarItem(title: BottomMenuNames.Subscriptions.rawValue, image: UIImage(named: BottomMenuNames.Subscriptions.rawValue), selectedImage: UIImage(named: BottomMenuNames.Subscriptions.rawValue)?.withRenderingMode(.alwaysOriginal))
        let inboxIcon = UITabBarItem(title: BottomMenuNames.Inbox.rawValue, image: UIImage(named: BottomMenuNames.Inbox.rawValue), selectedImage: UIImage(named: BottomMenuNames.Inbox.rawValue)?.withRenderingMode(.alwaysOriginal))
        let accountIcon = UITabBarItem(title: BottomMenuNames.Account.rawValue, image: UIImage(named: BottomMenuNames.Account.rawValue), selectedImage: UIImage(named: BottomMenuNames.Account.rawValue)?.withRenderingMode(.alwaysOriginal))
        
        homeIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        homeIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
        exploreIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        exploreIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
        subscriptionsIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        subscriptionsIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
        inboxIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        inboxIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
        accountIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        accountIcon.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
        
        homeController.tabBarItem = homeIcon
        exploreController.tabBarItem = exploreIcon
        subscriptionsController.tabBarItem = subscriptionsIcon
        inboxController.tabBarItem = inboxIcon
        accountController.tabBarItem = accountIcon
        
        viewControllers = [UINavigationController(rootViewController: homeController), UINavigationController(rootViewController: exploreController), UINavigationController(rootViewController: subscriptionsController), UINavigationController(rootViewController: inboxController), UINavigationController(rootViewController: accountController)]
        
        tabBar.backgroundColor = .darkGray
        tabBar.barStyle = .black
    }
}
