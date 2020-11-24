//
//  Array.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 13/11/20.
//

import Foundation

extension Array where Element == NSLayoutConstraint {
  func activate() {
    self.forEach { $0.isActive = true }
  }
  
  func deactivate() {
    self.forEach { $0.isActive = false }
  }
}

extension Array where Element == UIView {
  func addTo(_ view: UIView) {
    self.forEach(view.addSubview)
  }

  func addTo(_ view: UIStackView) {
    self.forEach(view.addArrangedSubview)
  }
}
