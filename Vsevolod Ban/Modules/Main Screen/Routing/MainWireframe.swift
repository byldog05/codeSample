//
//  MainWireframe.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class MainWireframe: MainWireframeProtocol {
    
    var mainViewController: MainViewController?
    
    var window: UIWindow?
    // Of course I can just present(_, animated) from Splash Screen, just to show animation + Transition
    func setupTabBarScreenViewControllerInWindow() {
        
        let mainViewController = UIStoryboard.init(name: MainViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
        self.mainViewController = mainViewController
        self.mainViewController?.navigator = self
        self.mainViewController?.interactor = MainInteractor()
    }
}
