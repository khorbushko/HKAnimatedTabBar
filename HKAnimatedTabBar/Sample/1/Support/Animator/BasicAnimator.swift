//
//  BasicAnimator.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class BasicAnimator {

  public enum Defaults {

    static let AnimationDuration: TimeInterval = 0.3
  }

  class func colorsAnimation(_ newColors: [UIColor], oldColors: [UIColor], duration: TimeInterval) -> CABasicAnimation {
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
    animation.fromValue = oldColors.compactMap({ $0.cgColor })
    animation.toValue = newColors.compactMap({ $0.cgColor })
    animation.duration = duration
    animation.isRemovedOnCompletion = true
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

    return animation
  }

  class func borderColorAnimation(_ fromColor: CGColor, newColor: CGColor, duration: TimeInterval) -> CABasicAnimation {
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
    animation.fromValue = fromColor
    animation.toValue = newColor
    animation.duration = duration
    animation.isRemovedOnCompletion = true
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

    return animation
  }
}
