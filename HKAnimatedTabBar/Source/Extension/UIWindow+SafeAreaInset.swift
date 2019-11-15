//
//  UIWindow+SafeAreaInset.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

extension UIWindow {

  // MARK: - UIWindow+SafeAreaInsets

  static var safeAreaBottomInset: CGFloat {
    get {
      var expectedOffset: CGFloat = 0

      if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        if let bottomOffset = window?.safeAreaInsets.bottom {
          expectedOffset = bottomOffset
        }
      }

      return expectedOffset
    }
  }
}
