//
//  CustomTabBarTransition.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 3/1/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//
import UIKit

class CustomTabBarTransition: UITabBarController {
    
    let transition = HorizonalSlideTransition()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = transition
    }
}

class HorizonalSlideTransition: NSObject, UIViewControllerAnimatedTransitioning, UITabBarControllerDelegate {
    
    enum Direction {
        case forward, backwards
    }
    var direction = Direction.forward
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let fromIndex = tabBarController.viewControllers?.index(of: fromVC)
            , let toIndex = tabBarController.viewControllers?.index(of: toVC)
            else { fatalError() }
        
        if toIndex > fromIndex { direction = .forward }
        else { direction = .backwards }
        
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from)
            , let toViewController = transitionContext.viewController(forKey: .to)
            , let fromView = transitionContext.view(forKey: .from)
            , let toView = transitionContext.view(forKey: .to)
            else { fatalError() }
        
        transitionContext.containerView.addSubview(toView)
        
        // Setup required frames
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        let width = transitionContext.containerView.bounds.width + 10
        let transform: CGAffineTransform
        
        // Starting location
        if direction == .forward {
            transform = CGAffineTransform(translationX: -width, y: 0)
        } else {
            transform = CGAffineTransform(translationX: width, y: 0)
        }
        
        // Start location
        toView.transform = transform.inverted() // start offscreen
        fromView.transform = .identity // start onscreen
        
        // End location
        let animations = {
            toView.transform = .identity // end onscreen
            fromView.transform = transform // end offscreen
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [], animations: animations, completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
            fromView.transform = .identity
        })
    }
}

