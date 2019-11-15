//
//  ViewController.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    if let tabBarController = self.tabBarController as? AnimatedTabBarController {

      tabBarController.tabBar.replaceView.gradientColors = [
        UIColor.white,
        UIColor.white,
        UIColor.gray
      ]

      let items = ExpandableTabItemModel.prepareItems()
      tabBarController.configureFor(items)
    }
  }
}
