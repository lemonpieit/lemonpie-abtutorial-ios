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
  private let textStackView = UIStackView()
  private let buttonsStackView = UIStackView()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let paddingView = UIView()
  private let animationView = AnimationView()
  private let actionButton = Button(type: .system)
  private let nextButton = Button(type: .system)
  
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
    Style.stackView(pageStackView, textStackView)
    Style.buttonsStackView(buttonsStackView)
    Style.titleLabel(titleLabel)
    Style.descriptionLabel(descriptionLabel)
    Style.animationView(animationView)
    Style.button(actionButton, action: actionTapped)
    Style.button(nextButton, action: nextTapped)
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
        
    [pageStackView.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 16),
     pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
     pageStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
     pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor)].activate()
    
    [actionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
     actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)].activate()
    
    [titleLabel, descriptionLabel].addTo(textStackView)
    [animationView, textStackView, buttonsStackView]
      .addTo(pageStackView)
    [nextButton]
      .addTo(buttonsStackView)
    
    [animationView.leftAnchor.constraint(equalTo: pageStackView.leftAnchor),
     animationView.rightAnchor.constraint(equalTo: pageStackView.rightAnchor)].activate()

    [descriptionLabel.leftAnchor.constraint(equalTo: pageStackView.leftAnchor, constant: 30),
     descriptionLabel.rightAnchor.constraint(equalTo: pageStackView.rightAnchor, constant: -30)].activate()

    pageStackView.setCustomSpacing(40, after: animationView)
  }
  
  // MARK: - User Actions
  
  private func actionTapped() {
    delegate?.pageViewController(self, actionButtonTappedAt: pageIndex)
  }
  
  private func nextTapped() {
    delegate?.pageViewController(self, nextButtonTappedAt: pageIndex)
  }
}

private extension ABTOnboardingPageViewController {
  enum Style {
    static func stackView(_ views: UIStackView...) {
      for view in views {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.alignment = .center
      }
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
    
    static func button(_ view: Button, action: @escaping () -> Void) {
      view.perform(action)
      view.translatesAutoresizingMaskIntoConstraints = false
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
        [animationView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.4)].activate()
        
        animationView.loopMode = animation.loopMode
        animationView.animation = animation.animation
        animationView.animationSpeed = animation.speed
        animationView.contentMode = animation.contentMode
        animationView.backgroundBehavior = animation.backgroundBehavior
        
        animationView.play()
      } else {
        animationView.isHidden = true
      }
    }
    
    static func button(_ button: Button, with style: ABTButtonAppearance) {
      button.titleFont = style.font
      button.contentEdgeInsets = style.padding
      button.backgroundColor = style.backgroundColor
      button.setTitleColor(style.titleColor, for: .normal)
      
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
