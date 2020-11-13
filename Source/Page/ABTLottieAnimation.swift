//
//  ABTLottieAnimation.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 12/11/2020.
//

import Lottie

/// A custom initializer that exposes Lottie animation API.
public class ABTLottieAnimation {
  
  /// Sets the animation backing the animation view.
  /// Setting this will clear the view’s contents, completion blocks and current state.
  /// The new animation will be loaded up and set to the beginning of its timeline.
  public var animation: Animation?
  
  /// Sets the speed of the animation playback.
  /// Defaults to 1.
  public var speed: CGFloat = 1
  
  /// Sets the loop behavior for play calls.
  /// Defaults to `.playOnce`.
  public var loopMode: LottieLoopMode = .playOnce
  
  /// Describes the behavior of an AnimationView when the app is moved to the background.
  /// Defaults to `.pauseAndRestore`.
  public var backgroundBehavior: LottieBackgroundBehavior = .pauseAndRestore
  
  /// Options to specify how a view adjusts its content when its size changes.
  /// Defaults to `.scaleAspectFit`.
  public var contentMode: UIView.ContentMode = .scaleAspectFit
  
  // MARK: - Inits
  
  public init(filepath: String, animationCache: AnimationCacheProvider? = nil) {
    self.animation = Animation.filepath(filepath, animationCache: animationCache)
  }
  
  public init(name: String, bundle: Bundle = .main, subdirectory: String? = nil, animationCache: AnimationCacheProvider? = nil) {
    self.animation = Animation.named(name, bundle: bundle, subdirectory: subdirectory, animationCache: animationCache)
  }
}
