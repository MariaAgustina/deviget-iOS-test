//
//  ThumbnailService.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/14/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

class ThumbnailService: NSObject {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (Data) -> Void) {

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
}
