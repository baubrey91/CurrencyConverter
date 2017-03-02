//
//  GrowShrinkTransition.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 3/1/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//
import UIKit

class GrowShrinkNavigationController: UINavigationController {
    
    let transition = GrowTransition()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = transition
    }
}

class GrowTransition: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
    
    private var operation: UINavigationControllerOperation!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from)
            , let toViewController = transitionContext.viewController(forKey: .to)
            , let fromView = transitionContext.view(forKey: .from)
            , let toView = transitionContext.view(forKey: .to)
            else { fatalError() }
        
        
        // Setup required frames
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        // Use transform for animations
        let zeroScale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        // Start scale
        if self.operation == .push {
            toView.transform = zeroScale // grow from center
            transitionContext.containerView.addSubview(toView)
        } else {
            fromView.transform = .identity // shrink from fullscreen
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        // End scale
        let animations = {
            if self.operation == .push {
                toView.transform = .identity // grow to fullscreen
            } else {
                fromView.transform = zeroScale // shrink to center
            }
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [], animations: animations, completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
        })
    }
}
