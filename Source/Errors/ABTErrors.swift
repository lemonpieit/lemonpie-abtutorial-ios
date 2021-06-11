//
//  ABTErrors.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 20/11/20.
//

import Foundation

enum ABTError: Error {
  case animationNotFoundWithName(String, Bundle)
  case animationNotFoundAtPath(String)
  case imageNotFound
  case fileNotSupported
  case cannotAdvanceToPage(Int)
}

extension ABTError: CustomNSError {
  var errorCode: Int {
    switch self {
    case .animationNotFoundWithName: return 0
    case .animationNotFoundAtPath: return 1
    case .imageNotFound: return 2
    case .fileNotSupported: return 3
    case .cannotAdvanceToPage: return 4
    }
  }
}

extension ABTError {
  var errorDescription: String {
    let checkPhrase = "Check whether the file is of the required format or it is available."
    
    switch self {
    case .animationNotFoundWithName(let name, let bundle):
      let bundleString = bundle == .main ? "the main bundle of the app" : "bundle '\(bundle)'"
      return "Cannot find animation named '\(name)' in \(bundleString). \(checkPhrase)"
      
    case .animationNotFoundAtPath(let path):
      return "Cannot find animation at path '\(path)'. \(checkPhrase)"

    case .imageNotFound:
      return "Cannot find the image. \(checkPhrase)"

    case .fileNotSupported:
      return "This file is not supported in this version of ABTutorial. Only .json file and images are supported. \(checkPhrase)"
      
    case .cannotAdvanceToPage(let index):
      return "The UIPageController cannot go to page at \(index) index."
    }
  }
}
