//
//  RedditService.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

class RedditService: RedditServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    typealias RedditPosts = (RedditListing?, String?) -> Void

    
      func getRedditPosts(completion: @escaping RedditPosts) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: "https://ssl.reddit.com/r/subreddit/top.json") {
            //TODO: in real world, must not expose app token
            urlComponents.queryItems = [URLQueryItem(name: "client_id", value:  "tC2KILjYPSoxmw"),
                                        URLQueryItem(name: "response_type", value:  "code"),
                                        URLQueryItem(name: "state", value:  "TEST"),
                                        URLQueryItem(name: "redirect_uri", value:  "redditapp://response"),
                                        URLQueryItem(name: "duration", value:  "permanent"),
                                        URLQueryItem(name: "scope", value:  "read")]
            
          guard let url = urlComponents.url else {
            return
          }

          dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }

            DispatchQueue.main.async {
                if let error = error {
                    completion(nil,error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self?.parse(data,completion: completion)
                }
            }
          }
            
          dataTask?.resume()
        }
      }
      
      private func parse(_ data: Data,completion: @escaping RedditPosts) {

    //        print(String(data: data, encoding: .utf8))
        
            do {
                let model = try JSONDecoder().decode(RedditListing.self, from: data)
                completion(model,nil)
            } catch {
                completion(nil,"Error parsing data from service")
            }

      }
}
