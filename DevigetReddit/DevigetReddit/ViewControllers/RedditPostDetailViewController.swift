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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Hello, this text will change"
    }
    


}
