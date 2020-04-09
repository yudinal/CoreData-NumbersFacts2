//
//  UsersViewController.swift
//  CoreData-NumbersFacts2
//
//  Created by Lilia Yudina on 4/8/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configureTableView()
        fetchUsers()
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // get a reference to the CreateUserViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue" {
            guard let createUserVC = segue.destination as? CreateUserViewController else {
                fatalError("could not segue to CreateUserViewController")
            }
            createUserVC.delegate = self
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    // segue to post vc and show only user's posts
}

extension UsersViewController: CreateUserDelegate {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User) {
        users.append(user) // will reload table view with new user
    }
}
