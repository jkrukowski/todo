//
//  TodoViewModelTests.swift
//  Todos
//
//  Created by Jan Krukowski on 10/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import XCTest
@testable import Todos

final class TodoViewModelTests: BaseTest {
    var viewModel: TodoViewModelType!
    var repository: TodoRepositoryType!
    
    override func setUp() {
        super.setUp()
        repository = TodoRepository(db: realm)
    }
    
    func testAdd() {
        viewModel = TodoViewModel(todo: Todo(), repository: repository)
        let name = "newname"
        viewModel.todo.name = name
        viewModel.commit()
        let all = repository.load(sort: .defaultValue)
        XCTAssertTrue(all.count == 1)
        XCTAssertTrue(all[0].name == name)
    }
    
    func testEdit() {
        let data = BaseTest.insertExampleData(repository)
        viewModel = TodoViewModel(todo: data[0], repository: repository)
        XCTAssertTrue(data[0] == viewModel.todo)
    }
}
