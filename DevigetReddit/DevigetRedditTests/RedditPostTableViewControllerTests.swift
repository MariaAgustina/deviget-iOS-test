//
//  RedditPostTableViewControllerTests.swift
//  DevigetRedditTests
//
//  Created by agustina markosich on 1/14/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import XCTest
@testable import DevigetReddit

class RedditPostTableViewControllerTests: XCTest {
    
    func testRedditServiceNilListing(){
        let vc : ReddiPostTableViewController = ReddiPostTableViewController()
        let mockRedditService = MockRedditService()
        mockRedditService.errorMessage = "404 Not found"
        vc.redditService = mockRedditService
        vc.viewDidLoad()
        XCTAssertNil(vc.redditListing)
    }
     
    
    func testRedditServiceNoNilListing(){
        
        let vc : ReddiPostTableViewController = ReddiPostTableViewController()
        let mockRedditService = MockRedditService()
        
        let redditPostData1 = RedditPostData(title: "Este es un post de prueba", created: 1231231231, author: "Agustina", thumbnail: nil, numberOfComments: 10, imageData: nil)
        let redditPost1 = RedditPost(data: redditPostData1)
        
        let redditPostData2 = RedditPostData(title: "Este es un post de prueba 2", created: 1231231231, author: "Joaquina", thumbnail: nil, numberOfComments: 12, imageData: nil)
        let redditPost2 = RedditPost(data: redditPostData2)
        
        let redditListingData = RedditListingData(children: [redditPost1,redditPost2])
        let redditListing = RedditListing(data: redditListingData)
        
        mockRedditService.redditListing = redditListing
        
        vc.redditService = mockRedditService
        vc.viewDidLoad()

        XCTAssertEqual(vc.redditListing?.data.children.count, 2)
        XCTAssertEqual(vc.redditListing?.data.children[0].data.title, "Este es un post de prueba")
        XCTAssertEqual(vc.redditListing?.data.children[1].data.title, "Este es un post de prueba 2")
        //TODO: should test other parameters
        
    }

    func testPsrseRedditService(){
        //TODO
    }
    
    func testTableViewContent(){
        let vc : ReddiPostTableViewController = ReddiPostTableViewController()
        let mockRedditService = MockRedditService()

        let redditPostData1 = RedditPostData(title: "Este es un post de prueba", created: 1231231231, author: "Agustina", thumbnail: nil, numberOfComments: 10, imageData: nil)
        let redditPost1 = RedditPost(data: redditPostData1)

        let redditPostData2 = RedditPostData(title: "Este es un post de prueba 2", created: 1231231231, author: "Markosich", thumbnail: nil, numberOfComments: 12, imageData: nil)
        let redditPost2 = RedditPost(data: redditPostData2)
        
        let redditPostData3 = RedditPostData(title: "Este es un post de prueba 3", created: 1231231231, author: "Agustina", thumbnail: nil, numberOfComments: 0, imageData: nil)
        let redditPost3 = RedditPost(data: redditPostData3)

        let redditListingData = RedditListingData(children: [redditPost1,redditPost2,redditPost3])
        let redditListing = RedditListing(data: redditListingData)

        mockRedditService.redditListing = redditListing

        vc.redditService = mockRedditService
        vc.viewDidLoad()

        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 3)
    }

    
}
