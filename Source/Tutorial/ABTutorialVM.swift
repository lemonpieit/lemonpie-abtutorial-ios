//
//  ABTutorialVM.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 18/11/20.
//

import UIKit

internal protocol ABTutorialViewModelDelegate: AnyObject {
  
  /// Updates and sets the current page to the `viewController` property of the `UIPageViewController`.
  func updateUI(for page: ABTOnboardingPageViewController)
}

internal final class ABTutorialViewModel {
  
  /// Contains every page of the onboarding.
  let pageItems: [ABTOnboardPage]
  
  /// The duration of the buttons animation.
  let animationDuration = 0.2
  
  /// The index of the page the user is seeing.
  private(set) var currentPageIndex = 0

  /// The index of the last page in `pageItems`.
  private var lastIndex: Int {
    pageItems.count - 1
  }

  /// Indicates whether the current page is the last page in `pageItems`.
  var isLastPage: Bool {
    currentPageIndex == lastIndex
  }

  /// Indicates whether the action button should appear in the current page.
  var shouldShowActionButton: Bool {
    pageAppearance.actionButtonTitle != nil && !isLastPage
  }
  
  // MARK: - Appearance
  
  let pageAppearance: ABTPageAppearance
  
  var backgroundColor: UIColor {
    pageAppearance.backgroundColor
  }
  
  var tintColor: UIColor {
    pageAppearance.tintColor
  }
  
  var actionAppearance: ABTButtonAppearance {
    pageAppearance.actionButtonAppearance
  }
  
  var nextAppearance: ABTButtonAppearance {
    pageAppearance.nextButtonAppearance
  }
  
  // MARK: - ABTutorialViewModel Delegate
  
  weak var delegate: ABTutorialViewModelDelegate?

  // MARK: - Inits
  
  required init(pageItems: [ABTOnboardPage], appearance: ABTPageAppearance) {
    self.pageItems = pageItems
    self.pageAppearance = appearance
  }
  
  // MARK: - Methods
  
  /// Sets the `currentPageIndex` to a specific index.
  /// - Parameter index: The page index to set.
  func setCurrentIndex(to index: Int) {
    currentPageIndex = index
  }
  
  /// Returns an `ABTOnboardPage` configuration at a specific index path.
  /// - Parameter index: The index of the desired page configuration.
  /// - Returns: An `ABTOnboardPage` configuration object.
  func pageAt(_ index: Int) -> ABTOnboardPage {
    return pageItems[index]
  }
  
  /// Returns a `ABTOnboardingPageViewController` at a specific index path.
  /// - Parameter index: The index of the desired page.
  /// - Returns: An optional `ABTOnboardingPageViewController` object.
  func viewControllerForPage(at index: Int) -> ABTOnboardingPageViewController? {
    guard
      index >= 0,
      index < pageItems.count else { return nil }

    let pageVC = ABTOnboardingPageViewController(pageIndex: index, page: pageItems[index], pageAppearance: pageAppearance)
        
    return pageVC
  }
  
  /// Returns the page after the current page.
  /// - Parameter viewController: The current page view controller.
  /// - Returns: An optional `ABTOnboardingPageViewController` object.
  func nextPage(from viewController: UIViewController) -> ABTOnboardingPageViewController? {
    let pageIndex = indexFor(viewController)
    
    return viewControllerForPage(at: pageIndex + 1)
  }
  
  /// Returns the page before the current page.
  /// - Parameter viewController: The current page view controller.
  /// - Returns: An optional `ABTOnboardingPageViewController` object.
  func previousPage(from viewController: UIViewController) -> ABTOnboardingPageViewController? {
    let pageIndex = indexFor(viewController)
    guard pageIndex != 0 else { return nil }

    return viewControllerForPage(at: pageIndex - 1)
  }
    
  /// Scrolls to the next page in `pageItems`.
  func goToNextPage() {
    advanceToPage(currentPageIndex + 1)
  }
  
  /// Scrolls to the last page in `pageItems`.
  func goToLastPage() {
    if currentPageIndex != lastIndex {
      advanceToPage(lastIndex)
    }
  }

  // MARK: - Helpers
  
  /// Returns the index of a page view controller.
  /// - Parameter viewController: The page view controller to use.
  func indexFor(_ viewController: UIViewController?) -> Int {
    guard let pageVC = viewController as? ABTOnboardingPageViewController else { return 0 }
    return pageVC.pageIndex
  }
  
  private func advanceToPage(_ pageIndex: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let nextPage = self?.viewControllerForPage(at: pageIndex) else { return }
      let nextPageIndex = nextPage.pageIndex
      
      self?.setCurrentIndex(to: nextPageIndex)
      self?.delegate?.updateUI(for: nextPage)
    }
  }
}

extension ABTutorial {
  enum Config {
    static func actionButton(_ button: UIButton, viewModel: ABTutorialViewModel) {
      if viewModel.shouldShowActionButton {
        button.setTitle(viewModel.pageAppearance.actionButtonTitle, for: .normal)
        button.isHidden = false
        
        UIView.animate(withDuration: viewModel.animationDuration) {
          button.alpha = 1
        }
      } else {
        UIView.animate(withDuration: viewModel.animationDuration) {
          button.alpha = 0
        } completion: { _ in
          button.isHidden = true
        }
      }
    }
    
    static func nextButton(_ button: UIButton, with title: String?) {
      if let title = title {
        button.setTitle(title, for: .normal)
      } else {
        Logger.warning(.missingNextButtonTitle)
        button.setTitle(NSLocalizedString("abtutorial_next_button", value: "Next", comment: ""), for: .normal)
      }
    }
  }
}
