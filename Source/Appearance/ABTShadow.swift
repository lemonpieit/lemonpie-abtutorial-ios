//
//  ABTShadow.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 12/11/2020.
//

import UIKit

/// Creates a custom shadow layer.
/// 
/// By default it is applied to the primary button.
///
/// You can create a shadow using the custom initializer:
///
/// ```swift
/// let shadow = ABTShadow(color: .black,
///                        radius: 10,
///                        opacity: 0.2,
///                        offset: .zero)
/// ```
///
/// And apply it using the ``apply(to:)`` method.
///
/// ```swift
/// shadow.apply(to: targetView)
/// ```
public struct ABTShadow {
  
  /// The color of the layer’s shadow. Animatable.
  internal let color: UIColor
  
  /// The blur radius (in points) used to render the layer’s shadow. Animatable.
  internal let radius: CGFloat
  
  /// The opacity of the layer’s shadow. Animatable.
  internal let opacity: Float
  
  /// The offset (in points) of the layer’s shadow. Animatable.
  internal let offset: CGSize
  
  /// Initializes the custom shadow.
  public init(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) {
    self.color = color
    self.radius = radius
    self.opacity = opacity
    self.offset = offset
  }
  
  /// Add an ``ABTShadow`` to a specifc `UIView`.
  /// - Parameter view: The view to which apply the shadow.
  public func apply(to view: UIView) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowRadius = radius
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = offset
  }
}
