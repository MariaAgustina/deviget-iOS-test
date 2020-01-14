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
    var activityIndicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating();
        activityIndicator.center = (UIDevice.current.userInterfaceIdiom == .pad) ?  CGPoint(x: view.bounds.width / 5, y: view.bounds.height / 2) : CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)

        view.addSubview(activityIndicator)
        
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
        
        //TODO: should show loading
        
        redditService.getRedditPosts(completion: { [weak self] redditPosts, errorMessage in
                    guard let redditListing = redditPosts else {
                        //TODO: should show error view
                        print(errorMessage ?? "There was an error with the reddit posts")
                        return
                    }
                    
                    self?.activityIndicator.stopAnimating()
                            
                    self?.redditListing = redditListing
                    self?.tableView.reloadData()
                    self?.tableView.setContentOffset(CGPoint.zero, animated: false)
                    
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
        
        if let redditPost =  self.redditListing?.data.children[indexPath.row] {
            postSelectiondelegate?.postSelected(redditPost)
        }

        
        if let _ = self.redditListing?.data.children[indexPath.row].data.thumbnail, let detailViewController = postSelectiondelegate as? RedditPostDetailViewController, let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
