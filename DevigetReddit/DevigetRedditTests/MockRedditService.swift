//
//  MockRedditService.swift
//  DevigetRedditTests
//
//  Created by agustina markosich on 1/14/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import DevigetReddit

public class MockRedditService: RedditServiceProtocol {
    
    var redditListing : RedditListing?
    var errorMessage: String?
    
    public func getRedditPosts(completion: @escaping (RedditListing?, String?) -> Void){
        completion(self.redditListing,self.errorMessage)
    }
    
}
