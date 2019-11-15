//
//  CABasicAnimation+Completio n.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

class CAAnimationClassDelegate: NSObject, CAAnimationDelegate {
  // MARK: - CAAnimation+Block

  var didStartAnimation: (() -> ())?
  var didEndAnimaition: ((Bool) -> ())?

  func animationDidStart(_ theAnimation: CAAnimation) {
    didStartAnimation?()
  }

  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    didEndAnimaition?(flag)
  }
}

extension CAAnimation {

  // MARK: - CAAnimation+Block

  var animationDidStart: (() -> ())? {
    set {
      if let callbackDelegate = delegate as? CAAnimationClassDelegate {
        callbackDelegate.didStartAnimation = newValue
      } else {
        let callbackDelegate = CAAnimationClassDelegate()
        callbackDelegate.didStartAnimation = newValue
        self.delegate = callbackDelegate
      }
    }
    get {
      if let animationDelegate = delegate as? CAAnimationClassDelegate {
        return animationDelegate.didStartAnimation
      }
      return nil
    }
  }

  var onComplete: ((Bool) -> ())? {
    set {
      self.isRemovedOnCompletion = false
      if let callbackDelegate = delegate as? CAAnimationClassDelegate {
        callbackDelegate.didEndAnimaition = newValue
      } else {
        let callbackDelegate = CAAnimationClassDelegate()
        callbackDelegate.didEndAnimaition = newValue
        self.delegate = callbackDelegate
      }
    }
    get {
      if let animationDelegate = delegate as? CAAnimationClassDelegate {
        return animationDelegate.didEndAnimaition
      }
      return nil
    }
  }
}
