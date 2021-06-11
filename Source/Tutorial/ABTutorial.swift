//
//  ABtutorial.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 11/11/2020.
//
//  v 1.1.3
//

import UIKit
import Lottie

/// The object that holds the tutorial `UIViewController`.
///
/// You can create a tutorial using the ``init(pageItems:pageAppearance:completion:)`` initializer:
///
/// ```swift
/// let tutorial = ABTutorial(pageItems: pageItems,
///                           pageAppearance: pageAppearance,
///                           completion: completion)
/// tutorial.presentFrom(self)
/// ```
/// - note:
/// `ABTutorial` supports by default the dark mode. If you to disable it, you can do that using the ``isDarkModeEnabled`` property.
///
public final class ABTutorial: UIViewController {
    
  deinit {
    //    completion?()
    print("Done")
  }
  
  // MARK: - Properties
  
  private let viewModel: ABTutorialViewModel
  private let completion: (() -> Void)?
  
  lazy var leading = nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
  lazy var trailing = nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    
  // MARK: - Elements
  
  private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
  private let actionButton = Button(type: .system)
  private let nextButton = Button(type: .system)
  
  // MARK: - Interface
  
  /// A Boolean value indicaing whether the dark mode is enabled.
  /// The default value is `true` which causes the view controller to inherit the interface style from the system.
  ///
  /// - Note: This value is not needed for iOS 12.0 or older.
  public var isDarkModeEnabled: Bool = true {
    didSet {
      if #available(iOS 13.0, *) {
        if isDarkModeEnabled {
          overrideUserInterfaceStyle = .unspecified
        } else {
          overrideUserInterfaceStyle = .light
        }
      }
    }
  }

  /// Presents the configured `OnboardViewController`.
  ///
  /// - Parameters:
  ///   - viewController: The presenting view controller.
  ///   - animated: Defines if the presentation should be animated. Defaults to `true`.
  public func presentFrom(_ viewController: UIViewController, animated: Bool = true) {
    viewController.present(self, animated: animated)
  }

  // MARK: - Inits
  
  /// Initializes a new ``ABTutorial`` to be presented.
  /// The onboard view controller encapsulates the whole onboarding flow.
  ///
  /// - Parameters:
  ///   - pageItems: An array of ``ABTOnboardPage`` items.
  ///   - pageAppearance: An optional configuration for page customization.
  ///   - completion: An optional completion block that gets executed when the onboarding is dismissed.
  public required init(pageItems: [ABTOnboardPage], pageAppearance: ABTPageAppearance = ABTPageAppearance(), completion: (() -> Void)? = nil) {
    self.viewModel = ABTutorialViewModel(pageItems: pageItems, appearance: pageAppearance)
    self.completion = completion

    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overrides
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    
    configureUI()
    configurePageViewController()
  }
    
  // MARK: - Configurations
  
  private func configureUI() {
    view.backgroundColor = viewModel.backgroundColor
    
    [actionButton, nextButton].addTo(view)
    
    actionButton.configure(with: viewModel.actionAppearance, action: actionTapped)
    nextButton.configure(with: viewModel.nextAppearance, action: nextTapped)
    
    configureButtons(forPage: 0)
    
    [actionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
     actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)].activate()
    
    [nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
     nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)].activate()
  }
  
  private func configurePageViewController() {
    let pageControlApperance = UIPageControl.appearance(whenContainedInInstancesOf: [ABTutorial.self])
    pageControlApperance.pageIndicatorTintColor = viewModel.tintColor.withAlphaComponent(0.3)
    pageControlApperance.currentPageIndicatorTintColor = viewModel.tintColor
    pageControlApperance.hidesForSinglePage = true
    
    pageViewController.setViewControllers([viewModel.viewControllerForPage(at: 0)!], direction: .forward, animated: false)
    pageViewController.delegate = self
    pageViewController.dataSource = self
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
    
    [pageViewController.view.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20),
     pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     pageViewController.view.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
     pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)].activate()
  }
    
  // MARK: - Helpers
    
  private func configureButtons(forPage index: Int) {
    let page = viewModel.pageAt(index)
    
    Config.actionButton(actionButton, viewModel: viewModel)
    Config.nextButton(nextButton, with: page.nextButtonTitle)
    
    UIView.animate(withDuration: viewModel.animationDuration, delay: 0, options: .curveEaseOut) {
      self.updateNextButtonConstraints()
    }
  }
  
  private func updateNextButtonConstraints() {
    nextButton.layoutIfNeeded()
    
    if nextButton.frame.width > (view.frame.width - 40) {
      [leading, trailing].activate()
    } else {
      if leading.isActive || trailing.isActive {
        [leading, trailing].deactivate()
      }
    }
    
    nextButton.layoutIfNeeded()
  }
  
  // MARK: - User Actions
  
  private func actionTapped() {
    if let pageAction = viewModel.pageAppearance.action {
      pageAction { [weak self] (action, error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        switch action {
        case .nextPage:
          self?.viewModel.goToNextPage()
          
        case .lastPage:
          self?.viewModel.goToLastPage()
          
        case .dismiss:
          self?.dismiss(animated: true, completion: self?.completion)
          
        case .none:
          break
        }
      }
    }
  }
  
  private func nextTapped() {
    if viewModel.isLastPage {
      dismiss(animated: true, completion: nil)
    } else {
      viewModel.goToNextPage()
    }
  }
}

extension ABTutorial: ABTutorialViewModelDelegate {
  func updateUI(for page: ABTOnboardingPageViewController) {
    configureButtons(forPage: page.pageIndex)
    pageViewController.setViewControllers([page], direction: .forward, animated: true)
  }
}

extension ABTutorial: UIPageViewControllerDataSource {  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return viewModel.previousPage(from: viewController)
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return viewModel.nextPage(from: viewController)
  }
  
  // MARK: - Page indicator
  
  public func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return viewModel.pageItems.count
  }
  
  public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return viewModel.currentPageIndex
  }
}

extension ABTutorial: UIPageViewControllerDelegate {
  public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if completed {
      let pageIndex = viewModel.indexFor(pageViewController.viewControllers?.first)
      
      viewModel.setCurrentIndex(to: pageIndex)
      configureButtons(forPage: pageIndex)
    }
  }
}
