//
//  SearchVC.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/04/18.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {

    // MARK: - Properties
    
    var users = [User]()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cell classes
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // separator insets
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        
        // configure nav controller
        configurNavController()
        
        // fetch users
        fetchUsers()

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        print("Username is \(user.username)")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    // MARK: - Handlers
    
    func configurNavController() {
        navigationItem.title = "Explore"
    }

    // MARK: - API
    
    func fetchUsers() {
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            
            // uid
            let uid = snapshot.key
            
            // snapshot value cast as dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            // construct user
            let user = User(uid: uid, dictionary: dictionary)
            
            // append
            self.users.append(user)
            
            // reload our table view
            self.tableView.reloadData()
            
        }
    }
}

