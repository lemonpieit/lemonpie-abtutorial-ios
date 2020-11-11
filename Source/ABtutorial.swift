//
//  ABtutorial.swift
//  ABtutorial
//
//  Created by Francesco Leoni on 11/11/2020.
//

import UIKit
import Lottie

public final class ABtutorial: UIViewController {
  
  private let animation: Animation?
  
  // MARK: - Inits
  
  public init(filepath: String, animationCache: AnimationCacheProvider? = nil) {
    self.animation = Animation.filepath(filepath, animationCache: animationCache)
    super.init(nibName: nil, bundle: nil)
  }
  
  public init(name: String, bundle: Bundle = .main, subdirectory: String? = nil, animationCache: AnimationCacheProvider? = nil) {
    self.animation = Animation.named(name, bundle: bundle, subdirectory: subdirectory, animationCache: animationCache)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overrides
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    guard let animation = animation else {
      print("Animation not found")
      return
    }
    
    let animationView = AnimationView(animation: animation)
    animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    animationView.center = view.center
    animationView.contentMode = .scaleAspectFill
    
    view.addSubview(animationView)
    
    animationView.play()
  }
}
