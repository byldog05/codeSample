//
//  UIWindow.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

//MARK: - UIWindow extension
extension UIWindow {
    
    /// Transition Options
    struct TransitionOptions {
        
        /// Curve of animation
        enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear:        key = CAMediaTimingFunctionName.linear.rawValue
                case .easeIn:        key = CAMediaTimingFunctionName.easeIn.rawValue
                case .easeOut:        key = CAMediaTimingFunctionName.easeOut.rawValue
                case .easeInOut:    key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
                }
                return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
            }
        }
        
        /// Direction of the animation
        enum AnimationType {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            /// - Returns: transition
            func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        var duration: TimeInterval = 0.5
        
        /// Direction of the transition (default is `toRight`)
        var direction: TransitionOptions.AnimationType = .toRight
        
        /// Style of the transition (default is `linear`)
        var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        var background: TransitionOptions.Background? = nil
        
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        init(direction: TransitionOptions.AnimationType = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        init() { }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    
    /// Change the root view controller of the window
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        
        var transitionWindow: UIWindow? = nil
        if let background = options.background {
            transitionWindow = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWindow?.rootViewController = UIViewController.newController(withView: view, frame: transitionWindow!.bounds)
            case .solidColor(let color):
                transitionWindow?.backgroundColor = color
            }
            transitionWindow?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let window = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                window.removeFromSuperview()
            })
        }
    }
}

//MARK: - UIViewController extension
extension UIViewController {
    
    // Create a new empty controller instance with given view
    // - Parameters:
    //   - view: view
    //   - frame: frame
    // - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}
