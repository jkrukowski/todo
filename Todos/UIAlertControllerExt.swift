//
//  UIAlertControllerExt.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func sorting(sort: SortType, didTapSort: ((SortType) -> Void)? = nil) -> UIAlertController {
        let sortingTitle = NSLocalizedString("Sorting", comment: "Eng: Sorting")
        let alertController = UIAlertController(title: sortingTitle, message: nil, preferredStyle: .actionSheet)
        let cancelTitle = NSLocalizedString("Cancel", comment: "Eng: Cancel")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alertController.addAction(cancelAction)
        let sortingTitles = getSortTitles(sort)
        let sortingActions = [
            UIAlertAction(title: sortingTitles[0], style: .default) { _ in didTapSort?(.name) },
            UIAlertAction(title: sortingTitles[1], style: .default) { _ in didTapSort?(.created) },
            UIAlertAction(title: sortingTitles[2], style: .default) { _ in didTapSort?(.priority) }
        ]
        for action in sortingActions {
            alertController.addAction(action)
        }
        return alertController
    }
    
    static private func getSortTitles(_ sort: SortType) -> [String] {
        let tick: String = "\u{2713}"
        let sortingTitles = [
            (NSLocalizedString("Name", comment: "Eng: Name"), SortType.name),
            (NSLocalizedString("Date", comment: "Eng: Date"), SortType.created),
            (NSLocalizedString("Priority", comment: "Eng: Priority"), SortType.priority)
        ]
        var result = [String]()
        for (key, val) in sortingTitles {
            if val == sort {
                result.append("\(tick) \(key)")
            } else {
                result.append("\(key)")
            }
        }
        return result
    }
}
