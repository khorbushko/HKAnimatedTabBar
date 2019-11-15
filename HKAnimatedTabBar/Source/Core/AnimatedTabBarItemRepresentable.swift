//
//  ExpandableTabBarItemRepresentable.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 4/1/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

/*
 View that represent object for tabBar button

 - Tag: 1001
 - Version: 0.1
 */
public protocol AnimatedTabBarItemRepresentable where Self: UIView {

  /// This function called when view is ready to be displayed but not configured yet
  ///  - Parameter item: item that contains current settings for button replacement see [AnimatedTabBarItemModel](x-source-tag://1000)
  func configure(item: AnimatedTabBarItemModel)

  /// This function triggered when user select/deselect tabBar item
  ///  - Parameter selected: indicate current selection state
  ///  - Parameter item: item that contains current settings for button replacement see [AnimatedTabBarItemModel](x-source-tag://1000)
  func switchToSelectedState(_ selected: Bool, item: AnimatedTabBarItemModel)
}
