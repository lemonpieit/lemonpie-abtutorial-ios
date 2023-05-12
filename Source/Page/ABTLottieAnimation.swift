//
//  ABTLottieAnimation.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 12/11/2020.
//

import UIKit
import Lottie

/// A custom initializer that exposes Lottie animation API.
public class ABTLottieAnimation {
  
  /// Sets the animation backing the animation view.
  /// Setting this will clear the view’s contents, completion blocks and current state.
  /// The new animation will be loaded up and set to the beginning of its timeline.
  public var animation: LottieAnimation?
  
  /// Sets the speed of the animation playback.
  /// Defaults to 1.
  public var speed: CGFloat = 1
  
  /// Sets the loop behavior for play calls.
  /// Defaults to `.loop`.
  public var loopMode: LottieLoopMode = .loop
  
  /// Describes the behavior of an AnimationView when the app is moved to the background.
  /// Defaults to `.pauseAndRestore`.
  public var backgroundBehavior: LottieBackgroundBehavior = .pauseAndRestore
  
  /// Options to specify how a view adjusts its content when its size changes.
  /// Defaults to `.scaleAspectFit`.
  public var contentMode: UIView.ContentMode = .scaleAspectFit
  
  
  /// Loads an animation from a specific filepath. Returns nil if an animation is not found.
  ///
  /// - Parameters:
  ///   - filepath: The absolute filepath of the animation to load. Eg. “/User/Me/starAnimation.json”
  ///   - animationCache: A cache for holding loaded animations. Optional.
  public init(filepath: String, animationCache: AnimationCacheProvider? = nil) {
    guard let animation = LottieAnimation.filepath(filepath, animationCache: animationCache) else {
      Logger.error(.animationNotFoundAtPath(filepath))
      return
    }
    
    self.animation = animation
  }
  
  /// Loads an animation model from a bundle by its name. Returns nil if an animation is not found.
  ///
  /// - Parameters:
  ///   - name: The name of the json file without the json extension.
  ///   - bundle: The bundle in which the animation is located. Defaults to Bundle.main.
  ///   - subdirectory: A subdirectory in the bundle in which the animation is located. Optional.
  ///   - animationCache: A cache for holding loaded animations. Optional.
  public init(name: String, bundle: Bundle = .main, subdirectory: String? = nil, animationCache: AnimationCacheProvider? = nil) {
    guard let animation = LottieAnimation.named(name, bundle: bundle, subdirectory: subdirectory, animationCache: animationCache) else {
      Logger.error(.animationNotFoundWithName(name, bundle))
      return
    }
    
    self.animation = animation
  }
}
