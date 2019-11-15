//
//  MultiColorGradientView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 3/30/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

class MultiColorGradientView: UIView {

  var colors: [UIColor] = [] {
    didSet {
      setNeedsLayout()
    }
  }

  @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
    didSet {
      setNeedsLayout()
    }
  }

  @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 0.5) {
    didSet {
      setNeedsLayout()
    }
  }

  private var gradientLayer: CAGradientLayer?

  // MARK: - LifeCycle

  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    gradientLayer = layer as? CAGradientLayer
    gradientLayer?.colors = colors.compactMap({ $0.cgColor })
    gradientLayer?.startPoint = startPoint
    gradientLayer?.endPoint = endPoint
  }
}

extension MultiColorGradientView {

  // MARK: - Public

  func animateChangeGradientToColors(_ colors: [UIColor], duration: TimeInterval) {
    let animation = BasicAnimator.colorsAnimation(colors, oldColors: self.colors, duration: duration)
    animation.onComplete = { _ in
      self.colors = colors
    }

    gradientLayer?.add(animation, forKey: nil)
  }

  func animateBorderColorChange(_ borderColor: UIColor, duration: TimeInterval) {
    if let oldColor = self.gradientLayer?.borderColor {
      let newColor = borderColor.cgColor
      let animation = BasicAnimator.borderColorAnimation(oldColor, newColor: newColor, duration: duration)
      animation.onComplete = { _ in
        self.gradientLayer?.borderColor = borderColor.cgColor
      }

      gradientLayer?.add(animation, forKey: nil)
    }
  }
}
