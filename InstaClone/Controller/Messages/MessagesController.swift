//
//  MessagesController.swift
//  InstaClone
//
//  Created by mitsuyoshi matsuo on 2019/05/03.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "MessagesCell"

class MessagesController: UITableViewController {


    // MARK: - Properties
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        // register cell
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentifier)

    }
    
    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did selected row")
    }
    
    // MARK: - Handlers
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navigationController = UINavigationController(rootViewController: newMessageController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Messages"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNewMessage))
    }
    
    

}
