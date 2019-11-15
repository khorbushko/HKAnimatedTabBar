//
//  TabBarReplaceView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 3/30/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final public class TabBarReplaceView: BaseView {

  private enum Defaults {

    enum Root {

      static let backgroundColor: UIColor = .white
    }

    enum ContainerView {

      static let cornerRadius: CGFloat = 18
      static let shadowColor: UIColor = UIColor(white: 1, alpha: 0)
      static let shadowOffset: CGSize = CGSize(width: 0, height: 6)
      static let shadowOpacity: Float = 0.5
      static let shadowRadius: CGFloat = 9
    }
  }

  public var contentContainerCornerRadius: CGFloat = Defaults.ContainerView.cornerRadius
  public var contentContainerShadowColor: UIColor = Defaults.ContainerView.shadowColor
  public var contentContainerShadowOffset: CGSize = Defaults.ContainerView.shadowOffset
  public var contentContainerShadowOpacity: Float = Defaults.ContainerView.shadowOpacity
  public var contentContainerShadowRadius: CGFloat = Defaults.ContainerView.shadowRadius

  private var gradientLayer: CAGradientLayer?

  public var startPointForGradient: CGPoint = CGPoint(x: 0, y: 1)
  public var endPointForGradient: CGPoint = CGPoint(x: 1, y: 0.3)

  public var gradientColors: [UIColor] = [] {
    didSet {
      gradientLayer?.removeFromSuperlayer()

      setNeedsLayout()
      layoutIfNeeded()

      if !gradientColors.isEmpty,
        let holderView = holderView {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = holderView.bounds
        gradientLayer?.colors = gradientColors.compactMap({ $0.cgColor })
        gradientLayer?.startPoint = startPointForGradient
        gradientLayer?.endPoint = endPointForGradient

        if let gradientLayer = gradientLayer {
          holderView.layer.insertSublayer(gradientLayer, at: 0)
        }
      }
    }
  }

  @IBOutlet private weak var holderView: UIView!
  @IBOutlet private weak var contentContainerView: UIView!

  private var shadowLayer: CALayer = CALayer()

  private var widthConstraints: [NSLayoutConstraint] = []
  private var itemsToControl: [AnimatedTabBarItemModel] = []

  private (set) var selectedItemIdentifier: String?
  public var selectedIndex: Int?

  public var onItemSwitch: ((Int) -> ())?
  public var onSameItemSelection: (() -> ())?

  // MARK: - LifeCycle

  override public func layoutSubviews() {
    super.layoutSubviews()

    holderView.setNeedsLayout()
    holderView.layoutIfNeeded()
    
    gradientLayer?.frame = holderView.bounds
    gradientLayer?.setNeedsLayout()
    setupAppearenceForContainerView()
  }

  // MARK: - Public

  public func selectElementAt(_ position: Int) {
    if itemsToControl.count <= position {
        unselectableEvent(position)
    } else {
      let item = itemsToControl[position]
      fireEvent(for: item)
    }
  }

  public func configureFor(_ items: [AnimatedTabBarItemModel]) {
    itemsToControl.removeAll()
    assert(itemsToControl.isEmpty, "invalid cleanUp logic")

    itemsToControl = items

    let subviews = holderView.subviews
    subviews.forEach({ $0.removeFromSuperview() })

    widthConstraints.removeAll()

    assert(widthConstraints.isEmpty, "invalid cleanUp logic")
    assert(holderView.subviews.isEmpty, "invalid cleanUp logic")

    var newViews: [UIView] = []

    for i in stride(from: 0, to: items.count, by: 1) {
      var currentItem = items[i]

      let holdingView = UIView()
      holdingView.tag = i
      newViews.append(holdingView)
      holdingView.addSubviewWithConstraints(currentItem.viewRepresentation, insets: UIEdgeInsets.zero)
      holdingView.translatesAutoresizingMaskIntoConstraints = false

      currentItem.action = fireEvent
    }

    assert(newViews.count == items.count, "invalid assigment logic")

    var allViewsConstraints: [NSLayoutConstraint] = []

    for i in stride(from: 0, to: newViews.count, by: 1) {
      let currentView = newViews[i]

      currentView.translatesAutoresizingMaskIntoConstraints = false
      holderView.addSubview(currentView)

      let superViewForCurrentView = currentView.superview
      let viewForLeading = i == 0 ? holderView : newViews[i - 1]

      let constraintTop = NSLayoutConstraint(item: currentView, attribute: .top, relatedBy: .equal, toItem: superViewForCurrentView, attribute: .top, multiplier: 1.0, constant: 0.0)

      let constraintBottom = NSLayoutConstraint(item: currentView, attribute: .bottom, relatedBy: .equal, toItem: superViewForCurrentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)

      let constraintLeading = NSLayoutConstraint(item: currentView, attribute: .leading, relatedBy: .equal, toItem: viewForLeading, attribute: i == 0 ? .leading : .trailing, multiplier: 1.0, constant: 0.0)

      let widthConstriant = NSLayoutConstraint(item: currentView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25.0)

      widthConstraints.append(widthConstriant)

      var constraints = [
        constraintTop,
        constraintBottom,
        constraintLeading,
        widthConstriant
      ]

      let needsToAddRelationConstraint = i != 0
      if needsToAddRelationConstraint {
        let relationView = newViews[0]
        let relationConstrains = NSLayoutConstraint(item: currentView, attribute: .width, relatedBy: .equal, toItem: relationView, attribute: .width, multiplier: 1.0, constant: 0.0)
        relationConstrains.priority = .defaultHigh
        constraints.append(relationConstrains)
      }

      let needToAddTrailingConstraint = i == (newViews.count - 1)
      if needToAddTrailingConstraint {
        let constraintTrailing = NSLayoutConstraint(item: currentView, attribute: .trailing, relatedBy: .equal, toItem: holderView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        constraints.append(constraintTrailing)
      }

      allViewsConstraints.append(contentsOf: constraints)
    }

    NSLayoutConstraint.activate(allViewsConstraints)

    for i in stride(from: 0, to: items.count, by: 1) {
      let currentItem = items[i]
      let currentView = currentItem.viewRepresentation
      currentView.configure(item: currentItem)
      currentView.switchToSelectedState(false, item: currentItem)
    }

    selectItemIfNeeded()
  }

  // MARK: - Private

  private func selectItemIfNeeded() {
    if selectedItemIdentifier == nil {
      if let selected = selectedIndex,
        itemsToControl.count > selected {
        let selectedItem = itemsToControl[selected]
        fireEvent(for: selectedItem)
      } else {
        if let first = itemsToControl.first {
          fireEvent(for: first)
        }
      }
    }
  }

  private func fireEvent(for item: AnimatedTabBarItemModel) {
    let isSameObjectSelected = item.identifier == selectedItemIdentifier
    if isSameObjectSelected {
      onSameItemSelection?()
      return
    }

    assert(!itemsToControl.isEmpty, "invalid assign items logic")
    assert(itemsToControl.count == widthConstraints.count, "invalid assign items and constraints logic")

    if let index = itemsToControl.firstIndex(where: { $0.identifier == item.identifier }) ,
          index < widthConstraints.count {

      var prevItem: AnimatedTabBarItemRepresentable?
      var prevItemModel: AnimatedTabBarItemModel?

      if let prevIndex = itemsToControl.firstIndex(where: { $0.identifier == selectedItemIdentifier }) {
        prevItemModel = itemsToControl[prevIndex]
        prevItem = prevItemModel?.viewRepresentation
      }

      self.selectedItemIdentifier = item.identifier
      onItemSwitch?(index)
      let constraintToControl = widthConstraints[index]
      let affectedItemModel = itemsToControl[index]
      let affectedItem = affectedItemModel.viewRepresentation

      assert(affectedItemModel.identifier == item.identifier, "invalid selection logic")
      affectedItem.switchToSelectedState(true, item: item)

      layoutIfNeeded()
      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [.curveEaseIn], animations: { [weak self] in
        let expectedComponentWidthCompact = (UIScreen.main.bounds.width - item.selectedComponentWidth) / 4
        self?.widthConstraints.forEach({ (constraintInList) in
          constraintInList.constant = expectedComponentWidthCompact
        })
        constraintToControl.constant = item.selectedComponentWidth
        self?.layoutIfNeeded()

        affectedItem.switchToSelectedState(true, item: affectedItemModel)
        if let prevItemModel = prevItemModel {
          prevItem?.switchToSelectedState(false, item: prevItemModel)
        }
      }, completion: nil)
    }
  }

  private func unselectableEvent(_ index: Int) {
    var prevItem: AnimatedTabBarItemRepresentable?
    var prevItemModel: AnimatedTabBarItemModel?

    if let prevIndex = itemsToControl.firstIndex(where: { $0.identifier == selectedItemIdentifier }) {
      prevItemModel = itemsToControl[prevIndex]
      prevItem = prevItemModel?.viewRepresentation
    }

    layoutIfNeeded()
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
      if let prevItemModel = prevItemModel {
        prevItem?.switchToSelectedState(false, item: prevItemModel)
      }
      self.onItemSwitch?(index)
      self.selectedItemIdentifier = nil
    }, completion: nil)
  }

  // MARK: - Appearence

  private func setupAppearenceForContainerView() {
    contentContainerView.layoutIfNeeded()

    drawMaskForContentContainer()
    configureShadowForContentContainer()
  }

  private func drawMaskForContentContainer() {
    let mask = CAShapeLayer()
    let cornerRadii = CGSize(width: contentContainerCornerRadius, height: contentContainerCornerRadius)
    let path = UIBezierPath(roundedRect: contentContainerView.bounds,
                            byRoundingCorners: [.topLeft, .topRight],
                            cornerRadii: cornerRadii)
    mask.frame = contentContainerView.bounds
    mask.path = path.cgPath
    mask.fillColor = UIColor.blue.cgColor
    contentContainerView.layer.mask = mask
  }

  private func configureShadowForContentContainer() {
    shadowLayer.removeFromSuperlayer()

    let cornerRadii = CGSize(width: contentContainerCornerRadius, height: contentContainerCornerRadius)
    let path = UIBezierPath(roundedRect: contentContainerView.bounds,
                            byRoundingCorners: [.topLeft, .topRight],
                            cornerRadii: cornerRadii)

    shadowLayer.frame = contentContainerView.bounds
    shadowLayer.shadowColor = contentContainerShadowColor.cgColor
    shadowLayer.shadowOpacity = contentContainerShadowOpacity
    shadowLayer.shadowOffset = contentContainerShadowOffset
    shadowLayer.shadowRadius = contentContainerShadowRadius

    layer.masksToBounds = false
    shadowLayer.shadowPath = path.cgPath

    layer.insertSublayer(shadowLayer, at: 0)
  }
}
