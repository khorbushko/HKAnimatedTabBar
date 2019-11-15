//
//  TabbarSelectable.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 7/15/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

// Should apply to root view controllers
public protocol TabbarSameTabSelectable where Self: UIViewController {

  func tabbarDidPressedTheSameTab()
}

// Should apply to visible view controllers
public protocol TabbarTabSwitchable where Self: UIViewController {

  func tabbarDidSwitchTab()
}
