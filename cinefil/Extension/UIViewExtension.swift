//
//  UIViewExtension.swift
//  cinefil
//
//  Created by zhou on 2/19/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

extension UIView {

    func addBackgroundLayer(from: UIColor, to: UIColor) {
        let gradient = CAGradientLayer()

        gradient.frame = bounds
        gradient.colors = [
            from.CGColor,
            to.CGColor
        ]
        layer.insertSublayer(gradient, atIndex: 0)
    }

}
