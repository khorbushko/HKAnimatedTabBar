//
//  HightLightableTabBarModel.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class HightLightableTabBarModel: AnimatedTabBarItemModel {

  var title: String {
    return type.title
  }

  var titleFont: UIFont = UIFont.systemFont(ofSize: 9)

  var activeTitleColor: UIColor {
    return type.activeTintColor
  }

  var inActiveTitleColor: UIColor {
    return type.inActiveTintColor
  }

  var activeTintColor: UIColor {
    return type.activeTintColor
  }

  var inActiveTintColor: UIColor {
    return type.inActiveTintColor
  }

  var elementGradientColors: [UIColor] {
    return type.gradientColors
  }

  var image: UIImage? {
    type.icon?.withRenderingMode(.alwaysTemplate)
  }

  var elementsActiveGradientColors: [UIColor] {
    return [
      UIColor.white,
      UIColor.white,
      UIColor.lightGray
    ]
  }

  var elementsInactiveGradientColors: [UIColor] {
    return [
      UIColor.white,
      UIColor.white,
      UIColor.white
    ]
  }

  var activeBottomViewHeight: CGFloat {
    return 24
  }

  var inactiveBottomViewHeight: CGFloat {
    return 8
  }

  let type: TabBarIconElement

  // MARK: - AnimatedTabBarItem

  var identifier: String = UUID().uuidString

  var viewRepresentation: AnimatedTabBarItemRepresentable

  var selectedComponentWidth: CGFloat {
    let visibleCount: CGFloat = 5
    let width = UIScreen.main.bounds.width / visibleCount
    return width
  }

  var action: ((AnimatedTabBarItemModel) -> ())?

  // MARK: - LifeCycle

  init(type: TabBarIconElement) {
    self.type = type
    let view = HightLightableTabBarView(frame: CGRect.zero)
    viewRepresentation = view

    view.action = { [weak self] _ in
      if let strongSelf = self {
        self?.action?(strongSelf)
      }
    }
  }
}

extension HightLightableTabBarModel {

  // MARK: - Generate

  class func prepareItems() -> [HightLightableTabBarModel] {

    let items: [TabBarIconElement] = TabBarIconElement.allCases

    let models = items.compactMap({ HightLightableTabBarModel(type: $0) })
    return models
  }
}
