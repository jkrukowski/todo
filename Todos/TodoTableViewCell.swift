//
//  TodoTableViewCell.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let id = "TodoTableViewCell"
    
    func configure(model: Todo) {
        self.textLabel?.text = model.name
        self.detailTextLabel?.text = model.text
    }
}
