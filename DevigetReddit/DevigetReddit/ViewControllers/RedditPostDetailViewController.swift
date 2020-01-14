//
//  RedditPostDetailViewController.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

class RedditPostDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}
extension RedditPostDetailViewController: PostSelectionDelegate {
    func postSelected(_ post: RedditPost) {
        
        descriptionLabel.text = post.data.title
        if let data =  post.data.imageData{
            postImageView.image = UIImage(data: data)

        }
    }
    
}
