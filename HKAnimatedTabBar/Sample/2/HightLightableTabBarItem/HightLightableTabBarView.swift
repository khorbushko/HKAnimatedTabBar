//
//  HightLightableTabBarView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import UIKit

final class HightLightableTabBarView: HKAnimatedTabBarBaseView, AnimatedTabBarItemRepresentable {

  var action: ((AnimatedTabBarItemRepresentable) -> ())?

  @IBOutlet private weak var bottomViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet private weak var itemNameTitle: UILabel!
  @IBOutlet private weak var itemLogoImageView: UIImageView!
  @IBOutlet private weak var bottomGradientView: MultiColorGradientView!
  @IBOutlet private weak var backgroundGradientColors: MultiColorGradientView!

  @IBOutlet private weak var bottomOffsetConstraint: NSLayoutConstraint!

  @IBOutlet private weak var overlayView: UIView!

  // MARK: - LifeCycle

  // MARK: - AnimatedTabBarItemRepresentable

  func configure(item: AnimatedTabBarItemModel) {
    if let model = item as? HightLightableTabBarModel {

      itemNameTitle.font = model.titleFont
      itemNameTitle.textColor = model.activeTitleColor
      itemNameTitle.text = model.title

      itemLogoImageView.image = model.image
      itemLogoImageView.tintColor = model.activeTintColor

      bottomGradientView.colors = model.elementGradientColors
      backgroundGradientColors.colors = model.elementsActiveGradientColors
    }
  }

  func switchToSelectedState(_ selected: Bool, item: AnimatedTabBarItemModel) {
    if let model = item as? HightLightableTabBarModel {

      if selected {

        layoutIfNeeded()
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseOut,
                       animations: {
          self.overlayView.alpha = 0
          self.bottomViewHeightConstraint.constant = model.activeBottomViewHeight
          self.itemLogoImageView.tintColor = model.activeTintColor
          self.backgroundGradientColors.animateChangeGradientToColors(model.elementsActiveGradientColors, duration: 0.2)
          self.backgroundGradientColors.alpha = 1
          self.layoutIfNeeded()
        })
      } else {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
          self.overlayView.alpha = 1
          self.bottomViewHeightConstraint.constant = model.inactiveBottomViewHeight
          self.itemLogoImageView.tintColor = model.inActiveTitleColor
          self.backgroundGradientColors.alpha = 0
          self.backgroundGradientColors.animateChangeGradientToColors(model.elementsInactiveGradientColors, duration: 0.3)
          self.layoutIfNeeded()
        }
      }
    }
  }

  // MARK: - Actions

  @IBAction private func buttonAction(_ sender: UIButton) {
    action?(self)
  }
}
