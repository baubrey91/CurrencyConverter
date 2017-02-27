//
//  Helper.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 2/26/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 1
        blurEffectView.frame = (superview?.bounds)!
        
        self.addSubview(blurEffectView)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
