//
//  Todo.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RealmSwift

final class Todo: Object {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var text = ""
    @objc dynamic var priority = Priority.normal.rawValue
    @objc dynamic var created = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["created", "name", "priority"]
    }
}
