//
//  App.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import UIKit

final class App {
    init(window: UIWindow?) {
        let viewController = TodoListViewController.instantiate()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
}
