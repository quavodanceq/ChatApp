//
//  Entity+CoreDataClass.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 11.07.2022.
//
//

import Foundation
import CoreData

@objc(Entity)
public class Entity: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
    }
}
