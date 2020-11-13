//
//  ABTButtonAppearance.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit

/// Defines the appearance of the `actionButton` and `nextButton`.
public struct ABTButtonAppearance {
  
  public enum CornerStyle {
    case rounded
    case custom(CGFloat)
  }
  
  /// The color used for the title text.
  ///
  /// - note: If not specified, defualts to whatever `textColor` is.
  internal let titleColor: UIColor

  /// The backgounr color used for the button backgound.
  ///
  /// - note: If not specified, defualts to `clear`.
  internal let backgroundColor: UIColor

  /// The corner radius used for the button.
  ///
  /// - note: If not specified, defualts to 0.
  internal let cornerRadius: CornerStyle

  /// The shadow used for the button.
  ///
  /// - note: If not specified, defualts to nil.
  internal let shadow: ABTShadow?

  /// The font used for the button.
  ///
  /// - note: If not specified, defualts to preferred body.
  internal let font: UIFont

  /// The padding used to inset the title.
  ///
  /// - note: If not specified, defualts to no padding.
  internal let padding: UIEdgeInsets

  public init(titleColor: UIColor = .black,
              backgroundColor: UIColor = .clear,
              cornerRadius: CornerStyle = .custom(0),
              shadow: ABTShadow? = nil,
              font: UIFont = .preferredFont(forTextStyle: .body),
              padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
    self.titleColor = titleColor
    self.backgroundColor = backgroundColor
    self.cornerRadius = cornerRadius
    self.shadow = shadow
    self.font = font
    self.padding = padding
  }
}
