//
//  Notes+CoreDataProperties.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionNote: String?
    @NSManaged public var addDate: Date?
    @NSManaged public var modifDate: Date?

}
