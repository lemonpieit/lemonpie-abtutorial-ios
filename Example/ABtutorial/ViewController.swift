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
  
  var tutorial: ABTutorial?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let customerCodeStep1 = ABTLottieAnimation(name: "step_01_data")
    
    let customerCodeStep2 = ABTLottieAnimation(name: "step_02_data")
    
    let customerCodeStep3 = ABTLottieAnimation(name: "step_04_data")
    
    let customerCodeStep4 = ABTLottieAnimation(name: "step_03_data")
    
    let button = ABTButtonAppearance(cornerRadius: .rounded,
                                     shadow: ABTShadow(color: .systemBlue, radius: 6, opacity: 0.5, offset: CGSize(width: 0, height: 5)),
                                     font: .systemFont(ofSize: 20, weight: .semibold),
                                     padding: UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50))
    
    let pageAppearance = ABTPageAppearance(titleFont: .systemFont(ofSize: 25, weight: .semibold),
                                           textFont: .systemFont(ofSize: 18, weight: .regular),
                                           nextButtonAppearance: button,
                                           actionButtonTitle: "Yes",
                                           action: { completion in
                                            completion(.lastPage, nil)
                                           })
    
    let page = ABTOnboardPage(title: "Codice cliente",
                              description: "Puoi trovare il tuo codice cliente nell'angolo in alto a destra della prima pagina della bolletta ABenergie.",
                              media: .animation(customerCodeStep1),
                              nextButtonTitle: "Puoi trovare il tuo codice")
    
    let page2 = ABTOnboardPage(title: "Codice di conferma",
                               description: "Per completare la registrazione ti verrà inviato un codice di conferma al contatto che hai lasciato in fase di sottoscrizione del contratto di fornitura con ABenergie. Per completare la registrazione ti verrà inviato un codice di conferma al contatto che hai lasciato in fase di sottoscrizione del contratto di fornitura con ABenergie.",
                               media: .animation(customerCodeStep2),
                               nextButtonTitle: "Ho capito!")
    
    let page3 = ABTOnboardPage(title: "Codice cliente",
                               description: "Puoi trovare il tuo codice cliente nell'angolo in alto a destra della prima pagina della bolletta ABenergie.",
                               media: .animation(customerCodeStep3),
                               nextButtonTitle: "Controlla costi Puoi trovare il tuo codicell")
    
    let page4 = ABTOnboardPage(title: "Codice di conferma",
                               description: "Per completare la registrazione ti verrà inviato un codice di conferma al contatto che hai lasciato in fase di sottoscrizione del contratto di fornitura con ABenergie.",
                               media: .animation(customerCodeStep4),
                               nextButtonTitle: "Ho capito!")
    
    tutorial = ABTutorial(pageItems: [page, page2, page3, page4],
                          pageAppearance: pageAppearance, completion: {
                            print("Done")
                          })
    
    tutorial?.isDarkModeEnabled = true
    tutorial?.presentFrom(self, animated: true)
  }
}
