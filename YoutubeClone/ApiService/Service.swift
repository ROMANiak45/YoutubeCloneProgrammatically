//
//  Service.swift
//  YoutubeClone
//
//  Created by Roman Croitor on 28/06/2020.
//  Copyright © 2020 Roman Croitor. All rights reserved.
//

import UIKit

class Service {
    static let shared = Service()
    
    func fetchVideos(from feed: String, completion: @escaping (Result<[Video], Error>) -> ()) {
        let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
        URLSession.shared.dataTask(with: URL(string: "\(baseURL)\(feed)")!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let videos = try jsonDecoder.decode([Video].self, from: data!)
                completion(.success(videos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

enum Feed: String {
    case home = "home.json"
    case explore = "trending.json"
    case subscriptions = "subscriptions.json"
}
