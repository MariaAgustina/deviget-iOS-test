//
//  RedditListing.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

public struct RedditListing: Codable {
    let data: RedditListingData
}

public struct RedditListingData: Codable {
    let children: [RedditPost]
}
