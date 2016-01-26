//
//  FavouriteCourses+CoreDataProperties.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-22.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FavouriteCourses {

    @NSManaged var coursename: String?
    @NSManaged var coursenumber: String?

}
