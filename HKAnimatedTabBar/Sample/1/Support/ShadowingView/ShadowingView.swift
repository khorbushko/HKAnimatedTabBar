//
//  ShadowingView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 7/15/19.
//  Copyright © 2019 . All rights reserved.
//


import UIKit

final class ShadowingView: UIView {

  var shadowColor: UIColor = UIColor.init(white: 1, alpha: 0) {
    didSet {
      setNeedsLayout()
    }
  }

  var shadowOffset: CGSize = CGSize(width: -1, height: 1.5) {
    didSet {
      setNeedsLayout()
    }
  }

  var shadowCornerRadius: CGFloat = 2 {
    didSet {
      setNeedsLayout()
    }
  }

  // MARK: - Life Cycle

  override func layoutSubviews() {
    super.layoutSubviews()

    addShadowLayer()
    updateShadowLayerPath()
  }

  override func action(for layer: CALayer, forKey event: String) -> CAAction? {
    guard event == "shadowPath" else {
      return super.action(for: layer, forKey: event)
    }

    guard let priorPath = layer.shadowPath else {
      return super.action(for: layer, forKey: event)
    }

    guard let sizeAnimation = layer.animation(forKey: "bounds.size") as? CABasicAnimation else {
      return super.action(for: layer, forKey: event)
    }

    let animation = sizeAnimation.copy() as? CABasicAnimation
    animation?.keyPath = "shadowPath"
    let action = ShadowingViewAction()
    action.priorPath = priorPath
    guard let anim = animation else {
      return nil
    }
    action.pendingAnimation = anim
    return action
  }

// MARK: - Public

  func hideShadow(_ hide: Bool) {
    layer.shadowOpacity = hide ? 0 : 1
  }

  // MARK: - Private

  private func addShadowLayer() {
    clipsToBounds = false

    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = shadowOffset
    layer.masksToBounds = false
  }

  private func updateShadowLayerPath() {
    layoutIfNeeded()

    let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -2, dy: -2), cornerRadius: shadowCornerRadius).cgPath
    layer.shadowPath = path
  }
}
