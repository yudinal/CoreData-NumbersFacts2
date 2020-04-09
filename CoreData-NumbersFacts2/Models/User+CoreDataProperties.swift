//
//  User+CoreDataProperties.swift
//  CoreData-NumbersFacts2
//
//  Created by Lilia Yudina on 4/9/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dob: Date?
    @NSManaged public var name: String?
    @NSManaged public var twitter: String?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension User {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: User)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: User)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}
