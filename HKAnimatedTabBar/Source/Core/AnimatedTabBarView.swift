//
//  TabBarReplaceView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 3/30/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

open class AnimatedTabBarView: UITabBar {

  public var onItemSwitch: ((Int) -> ())? {
    didSet {
      replaceView.onItemSwitch = onItemSwitch
    }
  }

  public var onSameItemSelection: (() -> ())? {
    didSet {
      replaceView.onSameItemSelection = onSameItemSelection
    }
  }

  private enum Defaults {

    static let standartHeight: CGFloat = 49
  }

  open var defaultHeight: CGFloat {
    return 75
  }

  private (set) var replaceView: TabBarReplaceView! //swiftlint:disable:this implicitly_unwrapped_optional

  public var calculatedAdditionalBottomSafeAreaOffset: CGFloat {
    get {
      let size = self.bounds
      let delta = size.height - defaultHeight
      return delta
    }
  }

  override open var items: [UITabBarItem]? {
    set { //swiftlint:disable:this unused_setter_value
      /* to avoid resize of standart barButtons and to avoid action interception from tabBar */
    }
    get {
      return []
    }
  }

  // MARK: - Public

  open func deselectAllItems() {
    replaceView.selectElementAt(Int.max)
  }

  open func selectElementAt(_ position: Int) {
    replaceView.selectElementAt(position)
  }

  // MARK: - Override

  override open func sizeThatFits(_ size: CGSize) -> CGSize {
    let expectedSystemSize = super.sizeThatFits(size)

    let newSize = CGSize(width: expectedSystemSize.width, height: defaultHeight + UIWindow.safeAreaBottomInset)
    return newSize
  }

  override open func awakeFromNib() {
    super.awakeFromNib()

    replaceView = TabBarReplaceView(frame: self.bounds)
    self.addSubviewWithConstraints(replaceView, insets: UIEdgeInsets.zero)
  }

  override open func layoutSubviews() {
    super.layoutSubviews()

    replaceView.setNeedsLayout()
  }

  // MARK: - Configuration

  public func configureFor(_ items: [AnimatedTabBarItemModel]) {
    replaceView.setNeedsLayout()
    replaceView.layoutIfNeeded()

    replaceView.configureFor(items)
    replaceView.layoutIfNeeded()
  }
}
