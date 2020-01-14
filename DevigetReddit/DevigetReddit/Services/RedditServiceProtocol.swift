//
//  RedditServiceProtocol.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

public protocol RedditServiceProtocol: class {
    func getRedditPosts(completion: @escaping (RedditListing?, String?) -> Void)
}
