//
//  OnboardPage.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import Lottie

public typealias ABTOnboardPageCompletion = (_ action: ABTActionType, _ error: Error?) -> Void
public typealias ABTOnboardPageAction = (@escaping ABTOnboardPageCompletion) -> Void

/// The action to perform when the secondary button is tapped.
public enum ABTActionType {
  case nextPage
  case lastPage
  case dismiss
  case none
}

/// The type of media to display in a single page.
public enum ABTMediaType {
  case image(UIImage?)
  case animation(ABTLottieAnimation)
}

/// The onboarding page model to use to create a tutorial page.
public struct ABTOnboardPage {
  
  /// The title text used for the top label of the tutorial page.
  let title: String

  /// A description text to be used underneath the title.
  let description: String

  /// An optional image to be used in the tutorial page.
  ///
  /// - note: If no image is used, the description label will adjust fill the empty space.
  let image: UIImage?

  /// An optional animation to be used in the tutorial page.
  ///
  /// - note: If no animation is used, the description label will adjust fill the empty space.
  let animation: ABTLottieAnimation?

  /// The title text to be used for the primary button that is used to go to the next page.
  let nextButtonTitle: String?

  /// Creates an `ABTOnboardPage` configuration.
  public init(title: String,
              description: String,
              media: ABTMediaType? = nil,
              nextButtonTitle: String? = nil) {
    self.title = title
    self.description = description
    self.nextButtonTitle = nextButtonTitle
    
    switch media {
    case .image(let image):
      if let image = image {
        self.image = image
      } else {
        self.image = nil
        Logger.error(.imageNotFound)
      }
      self.animation = nil
      
    case .animation(let animation):
      self.image = nil
      self.animation = animation
      
    default:
      self.image = nil
      self.animation = nil
    }
  }
}
