//
//  BaseView.swift
//  HKAnimatedTabBar
//
//  Created by Kyryl Horbushko on 15.11.2019.
//  Copyright © 2019 - present. All rights reserved.
//

import Foundation
import UIKit

public class BaseView: UIView {

  // MARK: Lyfecycle

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    prepareView()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    prepareView()
  }

  func prepareForUse() {
    /* dummy */
  }

  // MARK: Private

  private func prepareView() {
    let nameForXib = xibName()
    let nibs = Bundle(for: AnimatedTabBarController.self).loadNibNamed(nameForXib, owner: self, options: nil)
    if let view = nibs?.first as? UIView {
      view.backgroundColor = UIColor.clear
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubviewWithConstraints(view, insets: UIEdgeInsets.zero)

      prepareForUse()
    }
  }

  internal func xibName() -> String {
    let xibName = String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    return xibName
  }
}
