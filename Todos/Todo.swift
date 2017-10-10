//
//  Todo.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RealmSwift

final class TodoDbObject: Object {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var text = ""
    @objc dynamic var priority = Priority.normal.rawValue
    @objc dynamic var due: Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["created", "name", "priority"]
    }
    
    convenience init(model: Todo) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.text = model.text
        self.priority = model.priority.rawValue
        self.due = model.due
    }
}

struct Todo {
    let id: String
    var name: String
    var text: String
    var priority: Priority
    var due: Date?
    
    init() {
        self.id = NSUUID().uuidString
        self.name = ""
        self.text = ""
        self.priority = .normal
        self.due = nil
    }
}

extension Todo {
    init(model: TodoDbObject) {
        self.id = model.id
        self.name = model.name
        self.text = model.text
        self.priority = Priority(rawValue: model.priority)!
        self.due = model.due
    }
}
