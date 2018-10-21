//
//  RootWIreframe.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class RootWireframe {
    
    private let splashScreenWireframe: SplashScreenWireframe
    
    init() {
        self.splashScreenWireframe = SplashScreenWireframe.sharedInstance
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?, window: UIWindow) -> Bool {
        
        self.splashScreenWireframe.window = window
        self.splashScreenWireframe.presentSplashScreenViewControllerInWindow()
        
        return true
    }
}
