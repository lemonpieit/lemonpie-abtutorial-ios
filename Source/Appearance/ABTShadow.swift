//
//  ABTShadow.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 12/11/2020.
//

import Foundation

/// A custom initializer for a shadow layer.
public struct ABTShadow {
  
  /// The color of the layer’s shadow. Animatable.
  internal let color: UIColor
  
  /// The blur radius (in points) used to render the layer’s shadow. Animatable.
  internal let radius: CGFloat
  
  /// The opacity of the layer’s shadow. Animatable.
  internal let opacity: Float
  
  /// The offset (in points) of the layer’s shadow. Animatable.
  internal let offset: CGSize
  
  public init(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) {
    self.color = color
    self.radius = radius
    self.opacity = opacity
    self.offset = offset
  }
  
  /// Add an `ABTShadow` to a specifc `UIView`.
  /// - Parameter view: The view to which apply the shadow.
  public func apply(to view: UIView) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowRadius = radius
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = offset
  }
}
