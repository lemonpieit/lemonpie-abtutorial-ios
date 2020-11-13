//
//  OnboardPage.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import Foundation
import Lottie

public typealias OnboardPageCompletion = (_ showNextPage: Bool, _ error: Error?) -> Void
public typealias OnboardPageAction = (@escaping OnboardPageCompletion) -> Void

public struct ABTOnboardPage {
  
  /// The title text used for the top label of the tutorial page.
  let title: String

  /// A description text to be used underneath the title.
  let description: String

  /// An optional animation to be used in the tutorial page.
  ///
  /// - note: If no animation is used, the description label will adjust fill the empty space.
  let animation: ABTLottieAnimation?

  /// The title text to be used for the primary button that is used to go to the next page.
  let nextButtonTitle: String

  /// The title text to be used for the optional action button on the page.
  ///
  /// - note: If no action button title is set, the button will not appear.
  let actionButtonTitle: String?

  /// The action to be called when tapping the action button on the page.
  ///
  /// - note: calling the completion with a `true` value on the action will advance the onboarding to the next page.
  let action: OnboardPageAction?

  public init(title: String,
              description: String,
              animation: ABTLottieAnimation? = nil,
              nextButtonTitle: String = NSLocalizedString("onboarding_next_button", value: "Next", comment: ""),
              actionButtonTitle: String? = nil,
              action: OnboardPageAction? = nil) {
    self.title = title
    self.description = description
    self.animation = animation
    self.nextButtonTitle = nextButtonTitle
    self.actionButtonTitle = actionButtonTitle
    self.action = action
  }
}
