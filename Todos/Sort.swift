//
//  Sort.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation

enum SortType: String {
    case name
    case created
    case priority
    
    static var defaultValue: SortType {
        return .created
    }
}
