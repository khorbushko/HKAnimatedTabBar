//
//  SlideTransition.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 4/23/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

/**
 Default animation for switching between controllers

 - Tag: 1004
 - Version: 0.1
 */
final public class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {

  private var viewControllers: [UIViewController]?

  /// animation duration
  public static let transitionDuration: Double = 0.25

  // MARK: - LifeCycle

  /// initialization
  public init(viewControllers: [UIViewController]?) {
    self.viewControllers = viewControllers
  }

  deinit {
    viewControllers?.removeAll()
  }

  // MARK: - UIViewControllerAnimatedTransitioning

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return TimeInterval(SlideTransition.transitionDuration)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
      let fromView = fromVC.view,
      let fromIndex = indexFor(fromVC),
      let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
      let toView = toVC.view,
      let toIndex = indexFor(toVC) else {
        transitionContext.completeTransition(false)
        return
    }

    let frame = transitionContext.initialFrame(for: fromVC)
    var fromFrameEnd = frame
    var toFrameStart = frame

    let isMoveToRight = toIndex > fromIndex

    let advancedFrameOriginX = frame.origin.x + frame.width
    let previousFrameOriginX = frame.origin.x - frame.width

    fromFrameEnd.origin.x = isMoveToRight ? previousFrameOriginX : advancedFrameOriginX
    toFrameStart.origin.x = isMoveToRight ? advancedFrameOriginX : previousFrameOriginX
    toView.frame = toFrameStart

      transitionContext.containerView.addSubview(toView)

    UIView.animate(withDuration: SlideTransition.transitionDuration * 3.0,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.3,
                   options: .curveEaseOut,
                   animations: {
      fromView.frame = fromFrameEnd
      toView.frame = frame
    }) { (success) in
      fromView.removeFromSuperview()
      transitionContext.completeTransition(success)
    }
  }

  // MARK: - Private

  private func indexFor(_ targetController: UIViewController) -> Int? {
    guard let viewControllers = self.viewControllers else {
      return nil
    }

    for (index, viewController) in viewControllers.enumerated() {
      if viewController == targetController {
        return index
      }
    }

    return nil
  }
}
