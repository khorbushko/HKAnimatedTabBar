//
//  TabbarSelectable.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 7/15/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

/**
 Allow detect Same tab selection

 If controller conform this protocol AnimatedTabBar will return appropriate callback

 - Tag: 1005
 - Version: 0.1
 */
public protocol TabbarSameTabSelectable where Self: UIViewController {

  func tabbarDidPressedTheSameTab()
}

/**
 Allow detect tabBar switch action

 If controller conform this protocol AnimatedTabBar will return appropriate callback

 - Tag: 1007
 - Version: 0.1
 */
public protocol TabbarTabSwitchable where Self: UIViewController {

  func tabbarDidSwitchTab()
}
