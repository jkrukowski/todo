//
//  AppDelegate.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var app: App?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        app = App(window: window)
        return true
    }
}
