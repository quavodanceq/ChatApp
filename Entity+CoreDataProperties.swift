//
//  Entity+CoreDataProperties.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 13.07.2022.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var attribute: NSObject?

}

extension Entity : Identifiable {

}
