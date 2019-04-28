//
//  FeedVC.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/18.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedCellDelegate {
    
    // MARK: - Properties

    var posts = [Post]()
    var viewSinglePost = false
    var post: Post?
//    var currentKey: String?
//    var userProfileController: UserProfileVC?
    
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        

        // Register cell classes
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // configure logout button
        configureNavigationBar()
        
        // configure refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        // fetch posts
        if !viewSinglePost {
            fetchPosts()
        }
        
        // update user feeds
        updateUserFeeds()
    }

    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if viewSinglePost {
            return 1
        } else {
            return posts.count
        }
    }

    // Feed view profile image
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.delegate = self
        
        var post: Post!

        if viewSinglePost {
            if let post = self.post {
                cell.post = post
            }
        } else {
            cell.post = posts[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - FeedCellDelegate Protocol

    func handleUsernameTapped(for cell: FeedCell) {
        
        guard let post = cell.post else { return }
        
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        userProfileVC.user = post.user
        
        navigationController?.pushViewController(userProfileVC, animated: true)
        
    }
    
    func handleOptionsTapped(for cell: FeedCell) {
        print("handle options tapped")
    }
    
    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool) {
        
        guard let post = cell.post else { return }
        guard let postId = post.postId else { return }
        
        if post.didLike {
            
            post.adjustLikes(addLike: false, completion: { (likes) in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                self.updateLikesStructures(with: postId, addLike: false)
            })
            
        } else {
            
            post.adjustLikes(addLike: true, completion: { (likes) in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                self.updateLikesStructures(with: postId, addLike: true)
            })
        }
        
        guard let likes = post.likes else { return }
        cell.likesLabel.text = "\(likes) likes"

    }
    
    func handleCommentTapped(for cell: FeedCell) {
        print("handle comment tapped")
    }

    
    // MARK: - Handlers
    
    @objc func handleRefresh() {
        posts.removeAll(keepingCapacity: false)
//        self.currentKey = nil
        fetchPosts()
        collectionView?.reloadData()
    }
    
    @objc func handleShowMessages() {
        print("Handle show messages")
    }
    
    func updateLikesStructures(with postId: String, addLike: Bool) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if addLike {
            
            // updates user-likes structure
            USER_LIKES_REF.child(currentUid).updateChildValues([postId: 1])
            
            // updates post-likes structure
            POST_LIKES_REF.child(postId).updateChildValues([currentUid: 1])

        } else {
            
            // remove like from user-like structure
            USER_LIKES_REF.child(currentUid).child(postId).removeValue()
            
            // remove like from post-like structure
            POST_LIKES_REF.child(postId).child(postId).removeValue()
        }
    }
    
    func configureNavigationBar() {
        
        if !viewSinglePost {

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))

        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(handleShowMessages))
        
        self.navigationItem.title = "Feed"
    }

    @objc func handleLogout() {

        // declare alert controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add alert action
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                
                // attempt sign out
                try Auth.auth().signOut()
                
                // present login controller
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
                
                print("Successfully logged user out")

            } catch {
                
                // handle error
                print("Failed to sign out")
            }
        }))
        
        // add cancel action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)

    }
    
    // MARK: - API
    
    func updateUserFeeds() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        USER_FOLLOWING_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            
            let followingUserId = snapshot.key
            
            USER_POSTS_REF.child(followingUserId).observe(.childAdded, with: { (snapshot) in
                
                let postId = snapshot.key
                
                USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
            })
        }
        
        USER_POSTS_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            
            let postId = snapshot.key
            
            USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
        }
    }
    
    func fetchPosts() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        USER_FEED_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            
            let postId = snapshot.key
            
            Database.fetchPost(with: postId, completion: { (post) in
                
                self.posts.append(post)

                self.posts.sort(by: { (post1, post2) -> Bool in
                    return post1.creationDate > post2.creationDate
                })
                
                // stop refreshing
                self.collectionView?.refreshControl?.endRefreshing()
                
                self.collectionView?.reloadData()
            })
        }
    }
}
