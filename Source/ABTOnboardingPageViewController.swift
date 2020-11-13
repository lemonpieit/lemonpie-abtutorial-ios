//
//  OnboardPageViewController.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import Lottie

internal protocol ABTOnboardingPageViewControllerDelegate: class {
  
  /// Informs the `delegate` that the action button was tapped.
  ///
  /// - Parameters:
  ///   - pageVC: The `ABTOnboardingPageViewController` object.
  ///   - index: The page index.
  func pageViewController(_ pageVC: ABTOnboardingPageViewController, actionButtonTappedAt index: Int)
  
  /// Informs the `delegate` that the next button was tapped.
  ///
  /// - Parameters:
  ///   - pageVC: The `ABTOnboardingPage` object.
  ///   - index: The page index.
  func pageViewController(_ pageVC: ABTOnboardingPageViewController, nextButtonTappedAt index: Int)
}

internal final class ABTOnboardingPageViewController: UIViewController {
  
  // MARK: - Page elements
  
  private let pageStackView = UIStackView()
  private let buttonsStackView = UIStackView()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let animationView = AnimationView()
  private let actionButton = UIButton(type: .system)
  private let nextButton = UIButton(type: .system)
  
  // MARK: - Properties
  
  private let pageAppearance: ABTPageAppearance

  /// The index of the page.
  let pageIndex: Int
  
  // MARK: - ABTOnboardingPageViewController Delegate
  
  weak var delegate: ABTOnboardingPageViewControllerDelegate?
  
  // MARK: - Inits
  
  init(pageIndex: Int, pageAppearance: ABTPageAppearance) {
    self.pageIndex = pageIndex
    self.pageAppearance = pageAppearance
    
    super.init(nibName: nil, bundle: nil)
    customizeStyleWith(pageAppearance)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureViews()
  }
    
  // MARK: - Configurations
  
  /// Configures the `ABTOnboardingPageViewController` with an `ABTOnboardPage` object.
  ///
  /// - Parameters:
  ///   - page: The page properties to assign to the page.
  func configureWithPage(_ page: ABTOnboardPage) {
    Config.titleLabel(titleLabel, with: page.title)
    Config.descriptionLabel(descriptionLabel, with: page.description, in: pageStackView)
    Config.animationView(animationView, with: page.animation, in: pageStackView)
    Config.actionButton(actionButton, with: page.actionButtonTitle)
    Config.button(actionButton, with: pageAppearance.actionButtonAppearance)
    Config.nextButton(nextButton, with: page.nextButtonTitle)
    Config.button(nextButton, with: pageAppearance.nextButtonAppearance)
  }
  
  private func configureUI() {
    Style.stackView(pageStackView)
    Style.buttonsStackView(buttonsStackView)
    Style.titleLabel(titleLabel)
    Style.descriptionLabel(descriptionLabel)
    Style.animationView(animationView)
    Style.actionButton(actionButton)
    Style.nextButton(nextButton)
  }
  
  private func customizeStyleWith(_ appearanceConfiguration: ABTPageAppearance) {
    view.backgroundColor = appearanceConfiguration.backgroundColor
    
    titleLabel.textColor = appearanceConfiguration.titleColor
    titleLabel.font = appearanceConfiguration.titleFont
    
    descriptionLabel.textColor = appearanceConfiguration.textColor
    descriptionLabel.font = appearanceConfiguration.textFont
  }

  private func configureViews() {
    view.addSubview(pageStackView)
    view.addSubview(actionButton)
    
    [pageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
     pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
     pageStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
     pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)].forEach { $0.isActive = true }
    
    [actionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
     actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)].forEach { $0.isActive = true }
    
    [nextButton].forEach(buttonsStackView.addArrangedSubview)
    [animationView, titleLabel, descriptionLabel, buttonsStackView].forEach(pageStackView.addArrangedSubview)
    
    pageStackView.setCustomSpacing(30, after: descriptionLabel)
  }
    
  // MARK: - User Actions
  
  @objc fileprivate func actionTapped() {
    delegate?.pageViewController(self, actionButtonTappedAt: pageIndex)
  }
  
  @objc fileprivate func nextTapped() {
    delegate?.pageViewController(self, nextButtonTappedAt: pageIndex)
  }
}

private extension ABTOnboardingPageViewController {
  enum Style {
    static func stackView(_ view: UIStackView) {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.spacing = 16
      view.axis = .vertical
      view.alignment = .center
    }
    
    static func buttonsStackView(_ view: UIStackView) {
      view.axis = .horizontal
      view.spacing = 50
    }
    
    static func titleLabel(_ view: UILabel) {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.font = .preferredFont(forTextStyle: .title1)
      view.numberOfLines = 2
      view.adjustsFontSizeToFitWidth = true
      view.minimumScaleFactor = 0.7
      view.textAlignment = .center
    }
    
    static func descriptionLabel(_ view: UILabel) {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.font = .preferredFont(forTextStyle: .title3)
      view.numberOfLines = 7
      view.adjustsFontSizeToFitWidth = true
      view.minimumScaleFactor = 0.7
      view.textAlignment = .center
    }
    
    static func animationView(_ view: AnimationView) {
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func actionButton(_ view: UIButton) {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.titleLabel?.font = .preferredFont(forTextStyle: .title2)
      view.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
    }
    
    static func nextButton(_ view: UIButton) {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.titleLabel?.font = .preferredFont(forTextStyle: .title2)
      view.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
  }
}

private extension ABTOnboardingPageViewController {
  enum Config {
    static func titleLabel(_ label: UILabel, with title: String) {
      label.text = title
    }
    
    static func descriptionLabel(_ label: UILabel, with description: String, in superview: UIStackView) {
      label.text = description
    }
    
    static func animationView(_ animationView: AnimationView, with animation: ABTLottieAnimation?, in superview: UIStackView) {
      if let animation = animation {
        animationView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.4).isActive = true

        animationView.animation = animation.animation
        animationView.contentMode = animation.contentMode
        animationView.animationSpeed = animation.speed
        animationView.loopMode = animation.loopMode
        animationView.backgroundBehavior = animation.backgroundBehavior
        
        animationView.play()
      } else {
        animationView.isHidden = true
      }
    }
    
    static func button(_ button: UIButton, with style: ABTButtonAppearance) {
      button.setTitleColor(style.titleColor, for: .normal)
      button.titleLabel?.font = style.font
      button.backgroundColor = style.backgroundColor
      button.contentEdgeInsets = style.padding
      
      button.sizeToFit()
      
      switch style.cornerRadius {
      case .rounded:
        button.layer.cornerRadius = button.frame.height / 2
      case .custom(let radius):
        button.layer.cornerRadius = radius
      }
      
      if let shadow = style.shadow {
        shadow.apply(to: button)
      }
    }
    
    static func actionButton(_ button: UIButton, with title: String?) {
      if let actionTitle = title {
        button.setTitle(actionTitle, for: .normal)
      } else {
        button.isHidden = true
      }
    }
    
    static func nextButton(_ button: UIButton, with title: String) {
      button.setTitle(title, for: .normal)
    }
  }
}
