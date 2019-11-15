//
//  IndividualAppTabBarController.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class CustomTabBarController: AnimatedTabBarController {

  // MARK: - Override

  override func configure() {
    selectedIndex = 2
    tabBar.replaceView.selectedIndex = selectedIndex
    let items = HightLightableTabBarModel.prepareItems()
    configureFor(items)

    tabBar.replaceView.contentContainerShadowColor = UIColor.lightGray
    tabBar.replaceView.contentContainerShadowOpacity = 0.2
    tabBar.replaceView.contentContainerCornerRadius = 18

    tabBar.replaceView.gradientColors = [
      UIColor.white,
      UIColor.white,
      UIColor.gray
    ]
  }
}
