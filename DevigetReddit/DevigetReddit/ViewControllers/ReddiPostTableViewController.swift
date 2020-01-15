//
//  ReddiPostTableViewController.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/13/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

class ReddiPostTableViewController: UITableViewController {

    
    var redditService : RedditServiceProtocol = RedditService()
    var redditListing : RedditListing?
    public weak var postSelectiondelegate: PostSelectionDelegate?
    var activityIndicator : UIActivityIndicatorView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.style = .large
        activityIndicator?.startAnimating();
        activityIndicator?.center = (UIDevice.current.userInterfaceIdiom == .pad) ?  CGPoint(x: view.bounds.width / 5, y: view.bounds.height / 2) : CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)

        if let activityIndic = activityIndicator{
            view.addSubview(activityIndic)

        }
        
        setupTableView()
        getPosts()
    }

    private func setupTableView(){
        tableView.register(UINib(nibName:"RedditPostTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostCell")
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        

    }
    
    private func getPosts(){
                
        redditService.getRedditPosts(completion: { [weak self] redditPosts, errorMessage in
                    guard let redditListing = redditPosts else {
                        //TODO: should show error view
                        print(errorMessage ?? "There was an error with the reddit posts")
                        return
                    }
                    
                    self?.activityIndicator?.stopAnimating()
                    self?.activityIndicator?.removeFromSuperview()

                    self?.redditListing = redditListing
                    self?.tableView.reloadData()
                    
                })
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton){
        self.tableView.performBatchUpdates({
            let indexPath = IndexPath(
                item: sender.tag,
                section: 0
            )
            
            //TODO: this should be done with the server side in order to preserve app state and other front ends states
            self.redditListing?.data.children.remove(at: sender.tag)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            
        }, completion: { _ in
            self.tableView.reloadData()
        })
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.redditListing?.data.children.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : RedditPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RedditPostCell", for: indexPath) as? RedditPostTableViewCell, var redditPost =  self.redditListing?.data.children[indexPath.row]{
            
            cell.titleLabel.text = redditPost.data.title
            cell.authorLabel.text = redditPost.data.author
            cell.numberOfCommentsLabel.text = String(redditPost.data.numberOfComments) + " comments"
            cell.visitedImageView.isHidden = redditPost.data.visited
            
            cell.dismissButton.tag = indexPath.row
            cell.dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            
            
            if let imageUrl = redditPost.data.thumbnail, let url = URL(string: imageUrl){
                let thumbnailService = ThumbnailService()
                thumbnailService.downloadImage(url: url, completion:  { [weak self] data in
                    if let image : UIImage = UIImage(data: data){
                        cell.postImageView.image = image
                        redditPost.data.imageData = data
                        self?.redditListing?.data.children[indexPath.row] = redditPost
                    }
                })
            }
            
            return cell
        }
       
        return (tableView.dequeueReusableCell(withIdentifier: "RedditPostCell", for: indexPath))
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if var redditPost =  self.redditListing?.data.children[indexPath.row] {
            redditPost.data.visited = true
            self.redditListing?.data.children[indexPath.row] = redditPost
            postSelectiondelegate?.postSelected(redditPost)
        }
        
        if let _ = self.redditListing?.data.children[indexPath.row].data.thumbnail, let detailViewController = postSelectiondelegate as? RedditPostDetailViewController, let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
        self.tableView.reloadData()
    }
}
