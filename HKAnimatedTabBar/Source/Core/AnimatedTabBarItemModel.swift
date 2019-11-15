//
//  AnimatedTabBarItem.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 4/2/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

/*
 Represent model for tabBar item

 - Tag: 1000
 - Version: 0.1
 */
public protocol AnimatedTabBarItemModel {

  /// unique identifier of model
  var identifier: String { get }

  /// return view for model, descibed as AnimatedTabBarItemRepresentable, should be inherited from UIView
  var viewRepresentation: AnimatedTabBarItemRepresentable { get }

  /// describe size of item when selected
  var selectedComponentWidth: CGFloat { get }

  /// action which will be triggered when item selected
  var action: ((AnimatedTabBarItemModel) -> ())? { get set }
}
