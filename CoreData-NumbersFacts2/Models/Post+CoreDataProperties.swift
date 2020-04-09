//
//  Post+CoreDataProperties.swift
//  CoreData-NumbersFacts2
//
//  Created by Lilia Yudina on 4/9/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var number: Double
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var user: User?

}
