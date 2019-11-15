//
//  UIView+Subview.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

extension UIView {

  // MARK: - UIView+Subview

  func addSubviewWithConstraints(_ subview: UIView, insets: UIEdgeInsets) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    let views = [
      "subview": subview
    ]

    let metrics = [
      "left": insets.left,
      "right": insets.right,
      "top": insets.top,
      "bottom": insets.bottom
    ]

    addSubview(subview)

    var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[subview]-right-|",
                                                     options: [.alignAllLeading, .alignAllTrailing], metrics: metrics, views: views)
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subview]-bottom-|",
                                                                  options: [.alignAllTop, .alignAllBottom], metrics: metrics, views: views))
    NSLayoutConstraint.activate(constraints)
  }
}
