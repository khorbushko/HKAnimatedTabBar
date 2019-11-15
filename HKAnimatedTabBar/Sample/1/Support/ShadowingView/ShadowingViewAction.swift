//
//  ShadowingViewAction.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 7/15/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class ShadowingViewAction: NSObject, CAAction {

    var pendingAnimation: CABasicAnimation?
    var priorPath: CGPath?

    // MARK: - CAAction
    func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable: Any]?) {
        guard let layer = anObject as? CALayer, let animation = self.pendingAnimation else {
            return
        }

        animation.fromValue = self.priorPath
        animation.toValue = layer.shadowPath
        layer.add(animation, forKey: "shadowPath")
    }
}
