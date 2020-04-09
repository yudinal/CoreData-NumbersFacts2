//
//  CoreDataManager.swift
//  CoreData-NumbersFacts2
//
//  Created by Lilia Yudina on 4/9/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // implement singleton
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]() // User is a NSManagedObject
    private var posts = [Post]()
    
    // we need accesss to the persisitense container reference from the app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // viewContext is of type NSManagedObjectContext
    
    
    // CRUD - Create, Read, Update, Delete
    
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        //=============================================
        // save changes to the NSManagedObjectContext
        //=============================================
        // persistence - saving data
        // persistence we've used so far: user defaults, documents directory, firebase, core data, (iCloud)
        // similar to saving to documents directory
        
        do {
            try context.save() // NSManagedObjectContext
        } catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest()) // fetchRequest() gets all the objects from Core Data
            // Extra notes: we can use (NSPredicate) to sort and filter Core Dta objects during fetching
            // fetchRequest is of type NSFetchRequest
        } catch {
            print("fetching users error: \(error)")
        }
        return users
    }
    
    public func createPost(for user: User, numberFact: Double, title: String) -> Post {
        // create a Post
        let post = Post(entity: Post.entity(), insertInto: context) // empty post
        
        // set the post properties
        post.number = numberFact
        post.title = title
        
        // create relationship between post and user
        post.user = user // this relationship was created by ctrl - drag in the core data graphical model
        
        // saving Post to the NSManagedObjectContext (Core Data)
        do {
            try context.save()
        } catch {
            print("error saving post: \(error)") // throwing function ideal here
        }
        return post
    }
    
    // delete
    @discardableResult // silences the warnings if returned value is not used
    public func deletePost(_ post: Post) -> Bool {
        var wasDeleted = false
        context.delete(post)
        
        // save context
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("failed to delete post with error: \(error)")
        }
        return wasDeleted
    }
    public func fetchPosts()  -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("failed to fetch posts with error: \(error)") // all the posts [Post]
        }
        return posts
    }
}
