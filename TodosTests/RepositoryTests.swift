//
//  RepositoryTests.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Todos

final class RepositoryTests: BaseTest {
    var repository: TodoRepositoryType!
    override func setUp() {
        super.setUp()
        repository = TodoRepository(db: realm)
    }
    
    func testLoadEmpty() {
        XCTAssertTrue(repository.load(sort: .defaultValue).isEmpty)
    }
    
    func testLoadPredicateEmpty() {
        let predicate = NSPredicate(format: "name BEGINSWITH %@", "janek")
        XCTAssertTrue(repository.load(predicate: predicate, sort: .defaultValue).isEmpty)
    }
    
    func testRemoveLoadEmpty() {
        repository.remove(todo: Todo())
        XCTAssertTrue(repository.load(sort: .defaultValue).isEmpty)
    }
    
    func testAddRemoveLoad() {
        let todo = Todo()
        repository.add(todo: todo)
        XCTAssertFalse(repository.load(sort: .defaultValue).isEmpty)
        repository.remove(todo: todo)
        XCTAssertTrue(repository.load(sort: .defaultValue).isEmpty)
    }
    
    func testSortingDate() {
        let data = BaseTest.insertExampleData(repository)
        let all = repository.load(sort: .due)
        XCTAssertTrue(all[0].id == data[0].id)
    }
    
    func testSortingName() {
        let data = BaseTest.insertExampleData(repository)
        let all = repository.load(sort: .name)
        XCTAssertTrue(all[0].id == data[1].id)
    }
    
    func testFilterName() {
        _ = BaseTest.insertExampleData(repository)
        let predicate = NSPredicate(format: "name BEGINSWITH %@", "a")
        XCTAssertTrue(repository.load(predicate: predicate, sort: .defaultValue).count == 2)
    }
}
