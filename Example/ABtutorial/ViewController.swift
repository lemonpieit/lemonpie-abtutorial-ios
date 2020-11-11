//
//  ViewController.swift
//  ABtutorial
//
//  Created by fraleo2406 on 11/11/2020.
//  Copyright (c) 2020 fraleo2406. All rights reserved.
//

import UIKit
import ABtutorial

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let tutorial = ABtutorial(name: "servishero-loading")
    navigationController?.present(tutorial, animated: true)
  }
  
}

