//
//  Button.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 16/11/20.
//

import UIKit

open class Button: UIButton {
  
  private var action: (() -> Void)?
  
  private var gradientLayer: CAGradientLayer?
  
  // MARK: - Public properties

  /// The font of the title text.
  public var titleFont: UIFont! {
    didSet {
      titleLabel?.font = titleFont
    }
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer?.frame = bounds
  }
    
  // MARK: - Public methods

  /// Add an action to execute on the specified event.
  ///
  /// - Parameters:
  ///   - event: The control-specific events for which the action method is called.
  ///   - action: The action to perform.
  public func perform(for event: UIControl.Event = .touchUpInside, _ action: @escaping () -> Void) {
    self.action = action
    addTarget(self, action: #selector(actionToPerform), for: event)
  }

    /// Configures the button with an ``ABTButtonAppearance``.
    /// - Parameters:
    ///   - style: The style to apply to the button.
    ///   - action: The action to perform on a touch event.
  public func configure(with style: ABTButtonAppearance, action: @escaping () -> Void) {
    self.perform(action)
    self.titleFont = style.font
    self.contentEdgeInsets = style.padding
    self.backgroundColor = style.backgroundColor
    self.setTitleColor(style.titleColor, for: .normal)
    self.titleLabel?.minimumScaleFactor = 0.6
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.sizeToFit()
        
    if let shadow = style.shadow {
      shadow.apply(to: self)
    }
    
    if let gradient = style.gradient {
      self.gradientLayer = gradient
      self.layer.insertSublayer(gradient, at: 0)
    }
        
    switch style.cornerRadius {
    case .rounded:
      let cornerRadius = self.frame.height / 2
      self.gradientLayer?.cornerRadius = cornerRadius
      self.layer.cornerRadius = cornerRadius
      
    case .custom(let radius):
      self.layer.cornerRadius = radius
    }
  }

  // MARK: - Helpers
  
  @objc private func actionToPerform() {
    action?()
  }
}
