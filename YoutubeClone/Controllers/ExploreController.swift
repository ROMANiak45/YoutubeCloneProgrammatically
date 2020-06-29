//
//  ExploreController.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 29/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit
import JGProgressHUD

class ExploreController: HomeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    fileprivate func fetchVideos() {
        progressHud.textLabel.text = "Loading..."
        progressHud.show(in: self.view)
        
        Service.shared.fetchVideos(from: Feed.explore.rawValue) { [unowned self] (result) in
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
    
    fileprivate func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Explore"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
}
