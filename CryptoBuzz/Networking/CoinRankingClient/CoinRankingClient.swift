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
    
    static let base = "https://api.coinranking.com"
    
    class func fetchCoins(completion: @escaping ([Coin], ErrorMessage?) -> Void) {
        let endpoint = base + "/v1/public/coins?limit=20"
        guard let url = URL(string: endpoint) else {
            completion([], .invalidRequest)
            return
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 1)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion([], .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion([], .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion([], .invalidData)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(AllCoins.self, from: data)
                let coins = responseObject.data.coins
                completion(coins, nil)
            } catch {
                completion([], .invalidResponse)
            }
        }
        task.resume()
    }
    
    class func fetchIcon(urlString: String, completion: @escaping (SVGKImage?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache[urlString] {
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
    
    class func getCoinHistory(coinId: Int, timeFrame: String, completion: @escaping ([History], String?) -> Void) {
        let urlString = "https://api.coinranking.com/v1/public/coin/\(coinId)/history/\(timeFrame)"
        guard let url = URL(string: urlString) else {
            completion([], ErrorMessage.invalidRequest.rawValue)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    
            if error != nil {
                completion([], ErrorMessage.unableToComplete.rawValue)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion([], ErrorMessage.invalidResponse.rawValue)
                return
            }
            
            guard let data = data else {
                completion([], ErrorMessage.invalidData.rawValue)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(CoinHistoryResponse.self, from: data)
                let history = responseObject.data.history
                completion(history, nil)
            } catch {
                do {
                    let errorResposnse = try JSONDecoder().decode(CoinRankingResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion([], errorResposnse.localizedDescription)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}
    


var imageCache = [String: SVGKImage]()
