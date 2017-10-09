//
//  DetailViewController.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class DetailViewController: UIViewController {
    static func instantiate() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Todo", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        return viewController
    }
}
