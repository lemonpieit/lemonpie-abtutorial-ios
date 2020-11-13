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
    
    let customerCodeStep1 = ABTLottieAnimation(name: "step_01_data")
    customerCodeStep1.speed = 0.8
    customerCodeStep1.loopMode = .loop
    customerCodeStep1.contentMode = .redraw

    let customerCodeStep2 = ABTLottieAnimation(name: "step_02_data")
    customerCodeStep2.speed = 0.8
    customerCodeStep2.loopMode = .loop
    customerCodeStep2.contentMode = .redraw

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
    
    let page = ABTOnboardPage(title: "Codice cliente",
                              description: "Puoi trovare il tuo codice cliente nell'angolo in alto a destra della prima pagina della bolletta ABenergie.",
                              animation: customerCodeStep1,
                              nextButtonTitle: "Controlla costi",
                              actionButtonTitle: "Action",
                              action: { succ in
                                succ(false, nil)
                                print("VALERIA MARINI")
                              })
    
    let page2 = ABTOnboardPage(title: "Codice di conferma",
                               description: "Per completare la registrazione ti verrà inviato un codice di conferma al contatto che hai lasciato in fase di sottoscrizione del contratto di fornitura con ABenergie.",
                               animation: customerCodeStep2,
                               nextButtonTitle: "Ho capito!")

    let tutorial = ABTutorial(pageItems: [page, page2],
                              pageAppearance: pageAppearance) {
                                print("Done")
                              }
    
    tutorial.presentFrom(self, animated: true)
  }
}
