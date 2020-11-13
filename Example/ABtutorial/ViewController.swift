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
    
    let animation = ABTLottieAnimation(filepath: "/Users/francescoleoni/Desktop/ABtutorial.ios/Example/ABtutorial/Animations/servishero-loading.json")
    animation.speed = 0.8
    
    let button = ABTButtonAppearance(titleColor: .white,
                                     backgroundColor: .systemBlue,
                                     cornerRadius: .rounded,
                                     shadow: ABTShadow(color: .systemBlue, radius: 6, opacity: 0.5, offset: CGSize(width: 0, height: 5)),
                                     font: .systemFont(ofSize: 20, weight: .semibold),
                                     padding: UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50))
    
    let pageAppearance = ABTPageAppearance(tintColor: .black,
                                           titleFont: .systemFont(ofSize: 25, weight: .semibold),
                                           textFont: .systemFont(ofSize: 18, weight: .regular),
                                           nextButtonAppearance: button)
    
    let page = ABTOnboardPage(title: "Controlli gestione budget",
                              description: "Spesso controllare le tue spese può sembrare una missione impossibile, ma abbiamo fatto di tutto per semplificare il processo. Imposta un budget per le tue spese e monitoreremo le tue spese in tempo reale.",
                              animation: animation,
                              nextButtonTitle: "Controlla costi",
                              actionButtonTitle: "Action",
                              action: { succ in
                                succ(false, nil)
                                print("VALERIA MARINI")
                              })
    
    let page2 = ABTOnboardPage(title: "Controlli gestione budget",
                               description: "Spesso controllare le tue spese può sembrare una missione impossibile, ma abbiamo fatto di tutto per semplificare il processo.\nImposta un budget per le tue spese e monitoreremo le tue spese in tempo reale.",
                               animation: animation,
                               nextButtonTitle: "Ho capito!")
    
    let page3 = ABTOnboardPage(title: "Controlli gestione budget",
                               description: "Spesso controllare le tue spese può sembrare una missione impossibile, ma abbiamo fatto di tutto per semplificare il processo.\nImposta un budget per le tue spese e monitoreremo le tue spese in tempo reale.",
                               nextButtonTitle: "Ho capito!")

    let tutorial = ABTutorial(pageItems: [page, page2, page3],
                              pageAppearance: pageAppearance) {
                                print("Done")
                              }
    
    tutorial.presentFrom(self, animated: true)
  }
}
