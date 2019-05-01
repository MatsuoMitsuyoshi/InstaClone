//
//  NotificationsVC.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/18.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "NotificationCell"

class NotificationsVC: UITableViewController {

    // MARK: - Properties

    var notifications = [Notification]()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clear separator lines
        tableView.separatorColor = .clear
        
        // nav title
        navigationItem.title = "Notifications"

        // register cell class
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // fetch notifications
        fetchNotifications()
        
    }

    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell

        cell.notification = notifications[indexPath.row]

        return cell
    }
    
    // MARK: - NotificationCellDelegate

    
    // MARK: - Handlers

    
    
    // MARK: - API

    func fetchNotifications() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        NOTIFICATIONS_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            
            guard let dictionary  = snapshot.value as? Dictionary<String, AnyObject> else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            Database.fetchUser(with: uid, completion: { (user) in
                
                // if notification is for post
                if let postId = dictionary["postId"] as? String {
                    
                    Database.fetchPost(with: postId, completion: { (post) in
                        
                        let notification = Notification(user: user, dictionary: dictionary)
                        self.notifications.append(notification)
                        self.tableView.reloadData()
                    })
                    
                } else {
                    let notification = Notification(user: user, dictionary: dictionary)
                    self.notifications.append(notification)
                    self.tableView.reloadData()
                }
            })
        }
    }
    
}


