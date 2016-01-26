//
//  FavouriteCourses.swift
//  ScheduleBuilder
//
//  Created by Jorge Gomez on 2016-01-22.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import Foundation
import CoreData


class FavouriteCourses: NSManagedObject{
  @NSManaged var courseName : String
  @NSManaged var courseNumber : String
}