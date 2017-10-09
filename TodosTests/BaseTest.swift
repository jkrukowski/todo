//
//  BaseTest.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RealmSwift
import XCTest
import RxSwift
@testable import Todos

class BaseTest: XCTestCase {
    var realm: Realm!
    var bag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        self.bag = DisposeBag()
        self.realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.name))
    }
    
    static func insertExampleData(_ repository: TodoRepositoryType) -> [Todo] {
        let todos = [
            Todo(value: ["name": "ab"]),
            Todo(value: ["name": "aa"]),
            Todo(value: ["name": "ca"])
        ]
        for i in todos {
            repository.add(todo: i)
        }
        return todos
    }
}
