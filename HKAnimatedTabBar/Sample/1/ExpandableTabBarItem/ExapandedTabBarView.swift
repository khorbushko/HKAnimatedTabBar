//
//  ExapandedTabBarView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 4/1/19.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class ExapandedTabBarView: BaseView, AnimatedTabBarItemRepresentable {

  // MARK: - ExpandableTabBarItemRepresentable

  var action: ((AnimatedTabBarItemRepresentable) -> ())?

  @IBOutlet private weak var interactionView: ShadowingView!
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var gradientView: MultiColorGradientView!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!

  // MARK: - AnimatedTabBarItemRepresentable

  func configure(item: AnimatedTabBarItemModel) {
    if let model = item as? ExpandableTabItemModel {

      titleLabel.font = model.titleFont
      titleLabel.textColor = model.titleColor

      interactionView.shadowColor = model.shadowColor
      interactionView.shadowOffset = model.shadowOffset
      interactionView.shadowCornerRadius = interactionView.bounds.height / 2
      interactionView.hideShadow(true)

      interactionView.setNeedsLayout()
      interactionView.layoutIfNeeded()

      gradientView.layer.borderColor = model.borderColor.cgColor
      gradientView.layer.borderWidth = model.activeBorderWidth
      gradientView.layer.cornerRadius = gradientView.bounds.height / 2
      gradientView.colors = model.unselectedTileGradientColors

      imageView.image = model.image
      imageView.tintColor = model.imageTintColor
    }
  }

  func switchToSelectedState(_ selected: Bool, item: AnimatedTabBarItemModel) {
    if let model = item as? ExpandableTabItemModel {
      interactionView.hideShadow(!selected)

      if selected {
        titleLabel.text = model.title
        interactionView.shadowColor = model.shadowColor
        gradientView.colors = model.selectedTileGradientColors
        gradientView.layer.borderWidth = model.activeBorderWidth
      } else {
        titleLabel.text = nil
        interactionView.shadowColor = model.inactiveShadowColor
        gradientView.layer.borderWidth = model.inactiveBorderWidth
        gradientView.colors = model.unselectedTileGradientColors
      }
    }
  }

  // MARK: - LifeCycle

  override func awakeFromNib() {
    super.awakeFromNib()

    prepareAppearence()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    interactionView.shadowCornerRadius = interactionView.bounds.height / 2
  }

  // MARK: - Actions

  @IBAction private func buttonAction(_ sender: UIButton) {
    action?(self)
  }

  // MARK: - Private

  internal func prepareAppearence() {
    interactionView.hideShadow(true)
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
  }
}
