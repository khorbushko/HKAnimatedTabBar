//
//  TransitionTabBarController.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 3/30/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

/**
 Class that replace standart UITabBarController and provide possibility to use custom animated buttons

 - Author: Kyryl Horbushko, [contact](mailto:kirill.ge@gmail.com)
 - Version: 0.1
 - Tag: 1003
 */
open class AnimatedTabBarController: UITabBarController {

  /// The tab bar view associated with this controller.
  ///
  /// Represented by `AnimatedTabBarView`
  override open var tabBar: AnimatedTabBarView {
    get {
      return super.tabBar as! AnimatedTabBarView
    }
  }

  /// transition that will be used while switching from one controller to another
  open var transition: UIViewControllerAnimatedTransitioning {
    SlideTransition(viewControllers: self.viewControllers)
  }

  /// this callback will be called if you will try to access
  /// controller at index that not exist
  public var onOutOfBoundsItemAccessRequest: ((Int) -> ())?

  private (set) var previouslySelectedIndex: Int?

  // MARK: - LifeCycle

  override open func viewDidLoad() {
    super.viewDidLoad()

    delegate = self

    configure()

    viewControllers?.forEach({ (viewController) in
      if #available(iOS 11.0, *) {
//        viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBar.calculatedAdditionalBottomSafeAreaOffset, right: 0)
      }

      viewController.tabBarItem.title = nil
      viewController.tabBarItem.image = nil
      viewController.tabBarItem.isEnabled = false
    })

    UITabBar.appearance().layer.borderWidth = 0.0
    UITabBar.appearance().clipsToBounds = true
    UITabBar.appearance().backgroundImage = UIImage()
    let capInsets = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    UITabBar.appearance().shadowImage = UIImage().resizableImage(withCapInsets: capInsets, resizingMode: .stretch)

    tabBar.onItemSwitch = { [weak self] in
      self?.onItemSelection($0)
       ((self?.selectedViewController as? UINavigationController)?.topViewController as? TabbarTabSwitchable)?.tabbarDidSwitchTab()
    }

    tabBar.onSameItemSelection = { [weak self] in
      (self?.selectedViewController as? UINavigationController)?.popToRootViewController(animated: true)
      ((self?.selectedViewController as? UINavigationController)?.viewControllers.first as? TabbarSameTabSelectable)?.tabbarDidPressedTheSameTab()
    }

    callBackSetup()

    updatePrevSelectedControllerIndex(selectedIndex)
  }

  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    tabBar.layoutSubviews()
    view.bringSubviewToFront(tabBar)
  }

  // MARK: - Configuration

  internal func configure() {
    /* dummy */
  }

  open func callBackSetup() {
    /* dummy */
  }

  /// deselect all items
  public func deselectAllItems() {
    tabBar.deselectAllItems()
  }

  /// allow to select previously selected controller
  public func selectPrevController() {
    if let previouslySelectedIndex = previouslySelectedIndex {
      selectController(previouslySelectedIndex)
    }
  }

  // MARK: - Internal

  internal func updatePrevSelectedControllerIndex(_ index: Int?) {
    self.previouslySelectedIndex = index
  }

  internal func configureFor(_ items: [AnimatedTabBarItemModel]) {
    tabBar.configureFor(items)

    view.layoutSubviews()
  }

  internal func willTransitFrom(_ viewController: UIViewController, toViewController: UIViewController) {
    /* dummy */
  }

  internal func selectController(_ position: Int) {
    tabBar.selectElementAt(position)
  }

  internal func onItemSelection(_ index: Int) {
    DispatchQueue.main.async { [weak self] in
      self?.updatePrevSelectedControllerIndex(self?.selectedIndex)

      if index < (self?.viewControllers?.count ?? 0) {
        self?.selectedIndex = index
      } else {
        if self?.onOutOfBoundsItemAccessRequest != nil {
          self?.onOutOfBoundsItemAccessRequest?(index)
        }
      }
    }
  }
}

extension AnimatedTabBarController: UITabBarControllerDelegate {

  public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      willTransitFrom(fromVC, toViewController: toVC)

    return transition
  }
}
