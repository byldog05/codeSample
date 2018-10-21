//
//  ViewController.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController, Identifierable {

    var navigator: SplashScreenWireframe?
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CATransaction.begin()
        
        makePulsed(logo) // Maybe create dat screen without XML
        CATransaction.commit()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // Just a Fun Animation Made for Showing anmation skill)
    /// Animate View with Pulse Animation
    private func makePulsed(_ imageView: UIImageView) {
        
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.05
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.3
        pulse1.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = Constants.animationRepeatCount
        animationGroup.animations = [pulse1]
        
        animationGroup.delegate = self
        imageView.layer.add(animationGroup, forKey: "pulse")
    }
    
    // To Make sure we Have No Memory Leak
    deinit {
        print("Splash Screen deinited")
    }
    
    private struct Constants {
        
        static let animationRepeatCount: Float = 1
    }
}

extension SplashScreenViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        navigator?.presentTabBarScreenInWindow()
    }
}
