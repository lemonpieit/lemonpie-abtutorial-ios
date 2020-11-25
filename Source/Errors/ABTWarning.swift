//
//  ABTWarning.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 23/11/20.
//

import Foundation

enum ABTWarning {
  case missingMedia
  case missingNextButtonTitle
}

extension ABTWarning {
  var warningCode: Int {
    switch self {
    case .missingMedia: return 0
    case .missingNextButtonTitle: return 1
    }
  }
}

extension ABTWarning {
  var warningDescription: String {
    switch self {
    case .missingMedia:
      return "You didn't provide an image or a Lottie json animation. The empty space will be used by the title and description."
      
    case .missingNextButtonTitle:
      return "You didn't set the next button title. As title will be used a localized string with key [abtutorial_next_button] and value [Next]. To override this string provide your custom string while creating the ABOnboardPage or add a key in your localizable.string file with key [abtutorial_next_button]."
    }
  }
}
