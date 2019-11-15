//
//  ExpandableTabItemModel.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 4/2/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class ExpandableTabItemModel: AnimatedTabBarItemModel {

  var title: String {
    switch type {
    case ExpandableMenuItem.first:
      return "First title"
    case ExpandableMenuItem.second:
      return "Second"
    case ExpandableMenuItem.third:
      return "Third"
    case ExpandableMenuItem.forth:
      return "Forth long long title"
    case ExpandableMenuItem.fifth:
      return "Fifth title"
    }
  }

  var titleFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
  var titleColor: UIColor = UIColor.black

  var image: UIImage? {
    get {
      return UIImage(named: type.rawValue)?.withRenderingMode(.alwaysTemplate)
    }
  }

  var imageTintColor: UIColor {
    UIColor.black
  }

  var selectedTileGradientColors: [UIColor] = [
    UIColor.white,
    UIColor.lightGray.withAlphaComponent(0.5)
  ]

  var unselectedTileGradientColors: [UIColor] = []

  var shadowColor: UIColor = UIColor.lightGray
  var inactiveShadowColor: UIColor = .init(white: 1, alpha: 0)
  var shadowOpacity: Float = 0.5
  var shadowOffset: CGSize = CGSize(width: 0, height: 4)
  
  var inactiveShadowOpacity: Float = 0

  var activeBorderWidth: CGFloat = 1
  var inactiveBorderWidth: CGFloat = 0
  var borderColor: UIColor = UIColor.lightGray

  let type: ExpandableMenuItem

  // MARK: - AnimatedTabBarItem

  var identifier: String = UUID().uuidString

  var viewRepresentation: AnimatedTabBarItemRepresentable

  var selectedComponentWidth: CGFloat {
    get {
      let imageWidth: CGFloat = 30
      let offsetSide: CGFloat = 20
      let offsetBetweenElements: CGFloat = 10

      var totalWidth = imageWidth + offsetSide * 2 + offsetBetweenElements

      let maxWidth = UIScreen.main.bounds.width * 0.65
      let label = UILabel()
      label.font = titleFont
      label.text = title
      label.numberOfLines = 1
      let size = label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
      var width = size.width
      if width > maxWidth {
        width = maxWidth
      }

      totalWidth += width

      return totalWidth
    }
  }

  var action: ((AnimatedTabBarItemModel) -> ())?

  // MARK: - LifeCycle

  init(type: ExpandableMenuItem) {
    self.type = type
    let view = ExapandedTabBarView(frame: CGRect.zero)
    viewRepresentation = view

    view.action = { [weak self] _ in
      if let strongSelf = self {
        self?.action?(strongSelf)
      }
    }
  }
}

extension ExpandableTabItemModel {

  // MARK: - Generate

  class func prepareItems() -> [ExpandableTabItemModel] {
    let items = ExpandableMenuItem.allCases
    let models = items.compactMap({ ExpandableTabItemModel(type: $0)})
    return models
  }
}
