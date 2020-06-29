//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 26/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit
import JGProgressHUD

class HomeController: UICollectionViewController {
    // UI Components
    let progressHud = JGProgressHUD(style: .dark)
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    lazy var videoLauncher: VideoLauncher = {
        let launcher = VideoLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    // Data Components
    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCollectionView()
        
        setupNavigationBar()
    }
    
    fileprivate func fetchVideos() {
        progressHud.textLabel.text = "Loading..."
        progressHud.show(in: self.view)
        
        Service.shared.fetchVideos(from: Feed.home.rawValue) { [unowned self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [unowned self] in
                    self.progressHud.dismiss()
                    let errorHud = JGProgressHUD(style: .extraLight)
                    errorHud.textLabel.text = error.localizedDescription
                    errorHud.show(in: self.view, animated: true)
                    errorHud.dismiss(afterDelay: 3, animated: true)
                }
            case .success(let uploadedVideos):
                self.videos = uploadedVideos
                DispatchQueue.main.async { [unowned self] in
                    self.collectionView.reloadData()
                    self.progressHud.dismiss(animated: true)
                }
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .darkGray
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
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
    
    func showSettingMenuController(withTitle: String) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.view.backgroundColor = .white
        dummySettingViewController.navigationItem.title = withTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ((view.frame.width - 32) * 9 / 16) + 38
        return CGSize(width: view.frame.width, height: height + view.frame.width / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        videoLauncher.showVideoPlayer()
    }
}

