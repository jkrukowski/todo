//
//  TodoListViewController.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import UIKit

final class TodoListViewController: UIViewController {
    fileprivate var viewModel: TodoListViewModelType!
    
    static func instantiate(viewModel: TodoListViewModelType = TodoListViewModel()) -> TodoListViewController {
        let storyboard = UIStoryboard(name: "Todo", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
