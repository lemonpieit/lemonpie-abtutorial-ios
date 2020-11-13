//
//  ABtutorial.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 11/11/2020.
//

import UIKit
import Lottie

public final class ABTutorial: UIViewController {
  
  // MARK: - Properties
  
  private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
  private let pageItems: [ABTOnboardPage]
  private let pageAppearance: ABTPageAppearance
  private let completion: (() -> Void)?
  
  // MARK: - Inits
  
  /// Initializes a new `ABTutorial` to be presented.
  /// The onboard view controller encapsulates the whole onboarding flow.
  ///
  /// - Parameters:
  ///   - pageItems: An array of `ABTOnboardPage` items.
  ///   - pageAppearance: An optional configuration for page customization.
  ///   - completion: An optional completion block that gets executed when the onboarding is dismissed.
  public init(pageItems: [ABTOnboardPage], pageAppearance: ABTPageAppearance = ABTPageAppearance(), completion: (() -> Void)? = nil) {
    self.pageItems = pageItems
    self.pageAppearance = pageAppearance
    self.completion = completion
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overrides
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = pageAppearance.backgroundColor
    
    pageViewController.setViewControllers([pageViwControllerFor(pageIndex: 0)!], direction: .forward, animated: false)
    pageViewController.dataSource = self
    pageViewController.delegate = self
    pageViewController.view.frame = view.bounds
    
    let pageControlApperance = UIPageControl.appearance(whenContainedInInstancesOf: [ABTutorial.self])
    pageControlApperance.pageIndicatorTintColor = pageAppearance.tintColor.withAlphaComponent(0.3)
    pageControlApperance.currentPageIndicatorTintColor = pageAppearance.tintColor
    pageControlApperance.hidesForSinglePage = true

    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
  }
  
  // MARK: - Interface
  
  /// Presents the configured `OnboardViewController`.
  ///
  /// - Parameters:
  ///   - viewController: The presenting view controller.
  ///   - animated: Defines if the presentation should be animated.
  public func presentFrom(_ viewController: UIViewController, animated: Bool) {
    viewController.present(self, animated: animated)
  }
  
  // MARK: - Helpers
  
  private func pageViwControllerFor(pageIndex: Int) -> ABTOnboardingPageViewController? {
    let pageVC = ABTOnboardingPageViewController(pageIndex: pageIndex, pageAppearance: pageAppearance)
    
    guard
      pageIndex >= 0,
      pageIndex < pageItems.count else { return nil }
    
    pageVC.delegate = self
    pageVC.configureWithPage(pageItems[pageIndex])
    return pageVC
  }
  
  private func advanceToPageWithIndex(_ pageIndex: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let nextPage = self?.pageViwControllerFor(pageIndex: pageIndex) else { return }
      
      self?.pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
    }
  }
}

extension ABTutorial: UIPageViewControllerDataSource {
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    guard let pageVC = viewController as? ABTOnboardingPageViewController else { return nil }
    let pageIndex = pageVC.pageIndex
    guard pageIndex != 0 else { return nil }
    
    return pageViwControllerFor(pageIndex: pageIndex - 1)
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    guard let pageVC = viewController as? ABTOnboardingPageViewController else { return nil }
    let pageIndex = pageVC.pageIndex
    
    return pageViwControllerFor(pageIndex: pageIndex + 1)
  }
  
  // MARK: - Page indicator
  
  public func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pageItems.count
  }
  
  public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    if let currentPage = pageViewController.viewControllers?.first as? ABTOnboardingPageViewController {
      return currentPage.pageIndex
    }
    return 0
  }
}

extension ABTutorial: UIPageViewControllerDelegate { }

extension ABTutorial: ABTOnboardingPageViewControllerDelegate {
  func pageViewController(_ pageVC: ABTOnboardingPageViewController, actionButtonTappedAt index: Int) {
    if let pageAction = pageItems[index].action {
      pageAction { (showNextPage, error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        if showNextPage {
          self.advanceToPageWithIndex(index + 1)
        }
      }
    }
  }
  
  func pageViewController(_ pageVC: ABTOnboardingPageViewController, nextButtonTappedAt index: Int) {
    if index == pageItems.count - 1 {
      dismiss(animated: true, completion: self.completion)
    } else {
      advanceToPageWithIndex(index + 1)
    }
  }
}
