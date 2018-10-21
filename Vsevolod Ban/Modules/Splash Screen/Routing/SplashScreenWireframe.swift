//
//  SplashScreenWireframe.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class SplashScreenWireframe: SplashScreenWireframeProtocol {
    
    weak var splashViewController: SplashScreenViewController?
    
    var window: UIWindow?
    
    // Maybe Dependancy Injection
    static let sharedInstance = SplashScreenWireframe()
    fileprivate init() {}
    
    func presentSplashScreenViewControllerInWindow() {
        let splashScreenViewController = UIStoryboard.init(name: SplashScreenViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: SplashScreenViewController.identifier) as? SplashScreenViewController
        self.splashViewController = splashScreenViewController
        self.splashViewController?.navigator = self
        self.window?.rootViewController = splashScreenViewController
        self.window?.makeKeyAndVisible()
    }
    
    func presentTabBarScreenInWindow() {
        
        let mainViewController = UIStoryboard.init(name: MainViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
        
//        mainViewController?.navigator?.mainViewController = mainViewController
        
        var options = UIWindow.TransitionOptions()
        
        options.direction = .fade
        window?.setRootViewController(mainViewController!, options: options)
    }
}
