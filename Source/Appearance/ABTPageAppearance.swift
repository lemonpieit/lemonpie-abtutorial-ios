//
//  Styles.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit

/// Defines the appearance of the tutorial page.
public struct ABTPageAppearance {
    
  /// The color used for the title text.
  ///
  /// - note: If not specified, defualts to whatever `textColor` is.
  internal let titleColor: UIColor
  
  /// The color used for the description text (and title text `titleColor` if not set).
  ///
  /// - note: Defualts to `.darkText`.
  internal let textColor: UIColor
  
  /// The color used for onboarding background.
  ///
  /// - note: Defualts to white.
  internal let backgroundColor: UIColor
    
  /// The color used for the page indicator and buttons.
  ///
  /// - note: Defualts to the blue tint color used troughout iOS.
  internal let tintColor: UIColor

  /// The font used for the title and action button.
  ///
  /// - note: Defualts to preferred text style `.title1` (supports dinamyc type).
  internal let titleFont: UIFont
  
  /// The font used for the desctiption label and next button.
  ///
  /// - note: Defualts to preferred text style `.body` (supports dinamyc type).
  internal let textFont: UIFont
  
  /// An object used to customize the button used to go to the next page.
  ///
  /// - note: Defualts to nil.
  internal let nextButtonAppearance: ABTButtonAppearance
  
  /// An object used to customize the button used to trigger page specific action.
  ///
  /// - note: Defualts to nil.
  internal let actionButtonAppearance: ABTButtonAppearance
  
  /// The title text to be used for the optional action button on the page.
  ///
  /// - note: If no action button title is set, the button will not appear.
  internal let actionButtonTitle: String?

  /// The action to be called when tapping the action button on the page.
  ///
  /// - note: calling the completion with a `true` value on the action will advance the onboarding to the next page.
  internal let action: ABTOnboardPageAction?
  
  /// Defines the appearance of a page.
  public init(titleColor: UIColor? = nil,
              textColor: UIColor = Color.black,
              backgroundColor: UIColor = Color.white,
              tintColor: UIColor = Color.black,
              titleFont: UIFont = .preferredFont(forTextStyle: .title1),
              textFont: UIFont = .preferredFont(forTextStyle: .body),
              nextButtonAppearance: ABTButtonAppearance = ABTButtonAppearance(),
              actionButtonAppearance: ABTButtonAppearance = ABTButtonAppearance(),
              actionButtonTitle: String? = nil,
              action: ABTOnboardPageAction? = nil) {
    self.titleColor = titleColor ?? textColor
    self.textColor = textColor
    self.backgroundColor = backgroundColor
    self.tintColor = tintColor
    self.titleFont = titleFont
    self.textFont = textFont
    self.nextButtonAppearance = nextButtonAppearance
    self.actionButtonAppearance = actionButtonAppearance
    self.actionButtonTitle = actionButtonTitle
    self.action = action
  }
}

public class Color {
  
  private static var bundle: Bundle {
    Bundle(for: self)
  }

  public static var white: UIColor {
    return UIColor(named: "white", in: bundle, compatibleWith: nil)!
  }
  
  public static var black: UIColor {
    return UIColor(named: "black", in: bundle, compatibleWith: nil)!
  }

}
