//
//  TodoListViewModelTests.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import XCTest
@testable import Todos

final class TodoListViewModelTests: BaseTest {
    var viewModel: TodoListViewModelType!
    var repository: TodoRepositoryType!
    
    override func setUp() {
        super.setUp()
        repository = TodoRepository(db: realm)
        viewModel = TodoListViewModel(repository: repository)
    }
    
    func testLoad() {
        let inserted = BaseTest.insertExampleData(repository)
        let expectation = self.expectation(description: "Wait for load")
        viewModel.todos.subscribe(onNext: { result in
            XCTAssertTrue(result.count == inserted.count)
            expectation.fulfill()
        }).addDisposableTo(bag)
        viewModel.load(sort: .defaultValue)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFilter() {
        _ = BaseTest.insertExampleData(repository)
        let expectation = self.expectation(description: "Wait for load")
        viewModel.todos.subscribe(onNext: { result in
            XCTAssertTrue(result.count == 1)
            expectation.fulfill()
        }).addDisposableTo(bag)
        viewModel.filter(name: "aa")
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFilterEmpty() {
        _ = BaseTest.insertExampleData(repository)
        let expectation = self.expectation(description: "Wait for load")
        viewModel.todos.subscribe(onNext: { result in
            XCTAssertTrue(result.count == 0)
            expectation.fulfill()
        }).addDisposableTo(bag)
        viewModel.filter(name: "aax")
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdd() {
        let expectation = self.expectation(description: "Wait for load")
        viewModel.todos.subscribe(onNext: { result in
            XCTAssertTrue(result.count == 1)
            expectation.fulfill()
        }).addDisposableTo(bag)
        viewModel.add(todo: Todo())
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRemove() {
        let todo = Todo()
        repository.add(todo: todo)
        let expectation = self.expectation(description: "Wait for load")
        viewModel.todos.subscribe(onNext: { result in
            XCTAssertTrue(result.count == 0)
            expectation.fulfill()
        }).addDisposableTo(bag)
        viewModel.remove(todo: todo)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
