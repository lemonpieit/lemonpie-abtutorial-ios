//
//  OnboardPageViewController.swift
//  ABonboarding
//
//  Created by Francesco Leoni on 09/11/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import Lottie

internal final class ABTOnboardingPageViewController: UIViewController {
  
  // MARK: - Page elements
  
  private var imageView: UIImageView?
  private var animationView: AnimationView?

  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let paddingView = UIView()
    
  private let pageStackView = UIStackView()
  private let textStackView = UIStackView()

  // MARK: - Properties
  
  private let page: ABTOnboardPage
  
  /// The index of the page.
  let pageIndex: Int
  
  // MARK: - Inits
  
  init(pageIndex: Int, page: ABTOnboardPage, pageAppearance: ABTPageAppearance) {
    self.pageIndex = pageIndex
    self.page = page
    
    super.init(nibName: nil, bundle: nil)
    customizeStyleWith(pageAppearance)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureWithPage()
    configureUI()
    configureViews()
  }
  
  // MARK: - Configurations
  
  private func customizeStyleWith(_ appearanceConfiguration: ABTPageAppearance) {
    view.backgroundColor = appearanceConfiguration.backgroundColor
    
    titleLabel.textColor = appearanceConfiguration.titleColor
    titleLabel.font = appearanceConfiguration.titleFont
    
    descriptionLabel.textColor = appearanceConfiguration.textColor
    descriptionLabel.font = appearanceConfiguration.textFont
  }
  
  /// Configures the `ABTOnboardingPageViewController` with an `ABTOnboardPage` object.
  private func configureWithPage() {
    Config.titleLabel(titleLabel, with: page.title)
    Config.descriptionLabel(descriptionLabel, with: page.description, in: pageStackView)
    
    if let image = page.image {
      imageView = UIImageView()
      pageStackView.addArrangedSubview(imageView!)
      Config.imageView(imageView!, with: image, in: pageStackView)
    }
    
    if let animation = page.animation {
      animationView = AnimationView()
      pageStackView.addArrangedSubview(animationView!)
      Config.animationView(animationView!, with: animation, in: pageStackView)
    }
  }
  
  private func configureUI() {
    Style.stackView(pageStackView, textStackView)
    Style.titleLabel(titleLabel)
    Style.descriptionLabel(descriptionLabel)
    Style.media(imageView ?? animationView)
  }
  
  private func configureViews() {
    view.addSubview(pageStackView)
    [titleLabel, descriptionLabel].addTo(textStackView)
    [textStackView, paddingView].addTo(pageStackView)

    [pageStackView.topAnchor.constraint(equalTo: view.topAnchor),
     pageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     pageStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
     pageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].activate()
    
    if let media = imageView ?? animationView {
      [media.leadingAnchor.constraint(equalTo: pageStackView.leadingAnchor),
       media.trailingAnchor.constraint(equalTo: pageStackView.trailingAnchor)].activate()
      pageStackView.setCustomSpacing(40, after: media)
    }
    
    [descriptionLabel.leadingAnchor.constraint(equalTo: pageStackView.leadingAnchor, constant: 30),
     descriptionLabel.trailingAnchor.constraint(equalTo: pageStackView.trailingAnchor, constant: -30)].activate()
  }
}

private extension ABTOnboardingPageViewController {
  enum Style {
    static func stackView(_ views: UIStackView...) {
      for view in views {
        view.spacing = 16
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
      }
    }
    
    static func titleLabel(_ view: UILabel) {
      view.numberOfLines = 2
      view.textAlignment = .center
      view.minimumScaleFactor = 0.7
      view.adjustsFontSizeToFitWidth = true
      view.font = .preferredFont(forTextStyle: .title1)
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func descriptionLabel(_ view: UILabel) {
      view.numberOfLines = 10
      view.textAlignment = .center
      view.minimumScaleFactor = 0.7
      view.adjustsFontSizeToFitWidth = true
      view.font = .preferredFont(forTextStyle: .title3)
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func media(_ view: UIView?) {
      view?.translatesAutoresizingMaskIntoConstraints = false
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
    
    static func imageView(_ imageView: UIImageView, with image: UIImage?, in superview: UIStackView) {
      if let image = image {
        [imageView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.45)].activate()
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
      }
    }
    
    static func animationView(_ animationView: AnimationView, with animation: ABTLottieAnimation?, in superview: UIStackView) {
      if let animation = animation {
        [animationView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.45)].activate()
        
        animationView.loopMode = animation.loopMode
        animationView.animation = animation.animation
        animationView.animationSpeed = animation.speed
        animationView.contentMode = animation.contentMode
        animationView.backgroundBehavior = animation.backgroundBehavior
        
        animationView.play()
      } else {
        Logger.warning(.missingMedia)
        animationView.isHidden = true
      }
    }
  }
}
