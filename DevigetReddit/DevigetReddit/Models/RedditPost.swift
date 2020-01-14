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
    let author : String
    let thumbnail : String?
    let numberOfComments : Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case created = "created_utc"
        case author
        case thumbnail
        case numberOfComments = "num_comments"
    }
}

