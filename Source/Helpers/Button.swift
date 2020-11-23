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

  // MARK: - Helpers
  
  @objc private func actionToPerform() {
    action?()
  }
}