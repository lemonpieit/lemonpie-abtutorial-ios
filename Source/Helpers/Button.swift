//
//  Button.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 16/11/20.
//

import UIKit

open class Button: UIButton {
  
  private var action: (() -> Void)?
  
  // MARK: - Public properties

  /// The font of the title text.
  public var titleFont: UIFont! {
    didSet {
      titleLabel?.font = titleFont
    }
  }
    
  // MARK: - Public methods

  /// Add action to execute on the specified event.
  ///
  /// - Parameters:
  ///   - event: Constants describing the types of events possible for controls.
  ///   - action: The action to perform.
  public func perform(for event: UIControl.Event = .touchUpInside, _ action: @escaping () -> Void) {
    self.action = action
    addTarget(self, action: #selector(actionToPerform), for: event)
  }

  /// Configures the button with an `ABTButtonAppearance`.
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
    
    switch style.cornerRadius {
    case .rounded:
      self.layer.cornerRadius = self.frame.height / 2
    case .custom(let radius):
      self.layer.cornerRadius = radius
    }
    
    if let shadow = style.shadow {
      shadow.apply(to: self)
    }
  }

  // MARK: - Helpers
  
  @objc private func actionToPerform() {
    action?()
  }
}
