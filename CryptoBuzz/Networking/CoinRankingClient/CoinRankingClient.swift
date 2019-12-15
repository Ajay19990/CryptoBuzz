//
//  CoinRankingClient.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 12/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit
import SVGKit

class CoinRankingClient {
    
    static let host = "api.coinranking.com"
    static let scheme = "https"
    
    static var allCoinsUrl: URL {
        var components = URLComponents()
        components.host = host
        components.path = "/v1/public/coins"
        components.scheme = scheme
        
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "limit", value: "20"))
        return components.url!
    }
    
    static func fetchCoins(completion: @escaping ([Coin], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: allCoinsUrl) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(AllCoins.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject.data.coins, nil)
                }
            } catch {
                do {
                    let errorResponse = try JSONDecoder().decode(CoinRankingResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion([], errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error)
                    }
                }
            }
            
        }
        task.resume()
    }
    
    static func fetchIcon(urlString: String, completion: @escaping (SVGKImage?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache[urlString] {
            print("image form the cache ..........")
            completion(imageFromCache, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            let image = SVGKImage(data: data)
            imageCache[urlString] = image
            completion(image, nil)
        }
        task.resume()
        
    }
}
    


var imageCache = [String: SVGKImage]()
