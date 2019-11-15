//
//  TabBarIconElement.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

enum TabBarIconElement: Int, CaseIterable {

  case first = 0
  case second = 1
  case third = 2
  case forth = 3
  case fifth = 4

  var icon: UIImage? {
    switch self {
      case .first:
        return UIImage(named: "ic_firstElement")
      case .second:
        return UIImage(named: "is_secondElement")
      case .third:
        return UIImage(named: "is_thirdElement")
      case .forth:
        return UIImage(named: "ic_forthElement")
      case .fifth:
        return UIImage(named: "ic_fifthElement")
    }
  }

  var title: String {
    switch self {
      case .first:
        return "First"
      case .second:
        return "Second title"
      case .third:
        return "Third long long title"
      case .forth:
        return "Forth"
      case .fifth:
        return "Fifth"
    }
  }

  var activeTintColor: UIColor {
    return UIColor.black
  }

  var inActiveTintColor: UIColor {
    return UIColor.lightGray
  }

  var gradientColors: [UIColor] {
    switch self {
      case .first:
        return [
          UIColor.black,
          UIColor.white
          ]
      case .second:
        return [
          UIColor.white,
          UIColor.black
        ]

      case .third:
        return [
          UIColor.black,
          UIColor.white
      ]

      case .forth:
        return [
          UIColor.white,
          UIColor.black
        ]
      case .fifth:
        return [
          UIColor.black,
          UIColor.white
        ]
    }
  }
}
