//
//  RedditPost.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

struct RedditPost: Codable {
    let data: RedditPostData
    
}

struct RedditPostData: Codable {
    let title: String
    let created : Int64
}

