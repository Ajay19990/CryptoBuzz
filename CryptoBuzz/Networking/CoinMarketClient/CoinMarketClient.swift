//
//  CoinMarketClient.swift
//  CryptoBuzz
//
//  Created by Ajay Choudhary on 13/12/19.
//  Copyright © 2019 Ajay Choudhary. All rights reserved.
//

import UIKit

class CoinMarketClient {
    
    static let apiKey = "07def649-b91b-4119-bb8d-2902ee9c33e7"
    
    static let host = "pro-api.coinmarketcap.com"
    static let scheme = "https"
    
    
    static func fetchCoinInfo(symbol: String, completion: @escaping (String?) -> Void) {
        
        var coinInfoUrl: URL {
            var components = URLComponents()
            components.host = host
            components.path = "/v1/cryptocurrency/info"
            components.scheme = scheme
            
            components.queryItems = [URLQueryItem]()
            components.queryItems?.append(URLQueryItem(name: "CMC_PRO_API_KEY", value: apiKey))
            components.queryItems?.append(URLQueryItem(name: "symbol", value: symbol))
            return components.url!
        }
        
        let task = URLSession.shared.dataTask(with: coinInfoUrl) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            //json serialisation krke url nikalna hai
            do {
                if let responseObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    if let data = responseObject["data"] as? [String: Any] {
                        if let symbol = data[symbol] as? [String: Any] {
                            if let logoUrl = symbol["logo"] as? String {
                                completion(logoUrl)
                            }
                        }
                    }
                }
            } catch {
                completion(nil)
                print("Unable to fetch icons")
                //handle catch
            }
        }
        task.resume()

    }
    
    static func fetchIcon(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil)
                print(error)
                return
            }
            guard let data = data else {
                completion(nil)
                //completion(uimage, success, error)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
}
