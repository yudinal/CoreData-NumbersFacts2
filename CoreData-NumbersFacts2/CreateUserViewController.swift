//
//  CreateUserViewController.swift
//  CoreData-NumbersFacts2
//
//  Created by Lilia Yudina on 4/8/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//

import UIKit

// 1 - custom protocol
protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // 2 - custom protocol
    weak var delegate: CreateUserDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set a maximum date of today
        datePicker.maximumDate = Date()
    }


    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let usernameText = userNameTextField.text, !usernameText.isEmpty else {
            print("missing user name")
            return
        }
        
        // extract date from picker
        let date = datePicker.date
        
        // create a user
        let user = CoreDataManager.shared.createUser(name: usernameText, dob: date)
        
        // call delegate method
        delegate?.didCreateUser(self, user: user)
        // UserViewController will now have access to the created user and get a delegation notification about the new user
        
        dismiss(animated: true)
    }
    
   
}
