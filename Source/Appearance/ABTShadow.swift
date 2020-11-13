//
//  ABTShadow.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 12/11/2020.
//

import Foundation

/// A custom initializer for a shadow layer.
public struct ABTShadow {
  
  let color: UIColor
  let radius: CGFloat
  let opacity: Float
  let offset: CGSize
  
  public init(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) {
    self.color = color
    self.radius = radius
    self.opacity = opacity
    self.offset = offset
  }
  
  public func apply(to view: UIView) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowRadius = radius
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = offset
  }
}
