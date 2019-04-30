//
//  NotificationsVC.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/18.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationsVC: UITableViewController {

    // MARK: - Properties

    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clear separator lines
        tableView.separatorColor = .clear
        
        // nav title
        navigationItem.title = "Notifications"

        // register cell class
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }

    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        return cell
    }
    
    // MARK: - NotificationCellDelegate

    
    // MARK: - Handlers

    
    
    // MARK: - API

    
}


