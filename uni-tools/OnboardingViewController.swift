//
//  OnboardingViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 20/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
//import paper_onboarding
import Onboard

class OnboardingVC: UIViewController {
    
    @IBOutlet var onboardingObj: OnboardingClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        onboardingObj.dataSource = self
        
        let firstPage = OnboardingContentViewController(title: "first", body: "body first", image: UIImage(named: "rocket"), buttonText: "Skip") { () -> Void in
            
        }
        
        let secondPage = OnboardingContentViewController(title: "second", body: "body second", image: UIImage(named: "rocket"), buttonText: "Skip") { () -> Void in
            
        }
        let onboardingVC = OnboardingVC(backgroundImage: UIImage(named: "background"), contents: [firstPage, secondPage])

    }
    
    
    
}

//extension OnboardingViewController: PaperOnboardingDataSource {
//
//    func onboardingItemsCount() -> Int {
//        return 2
//    }
//
//    func onboardingItem(at index: Int) -> OnboardingItemInfo {
//        let backgroundOne = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//        let backgroundTwo = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        let backgroundThree = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//        let textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//
//        let titleFont = UIFont(name: "HelveticaNeue-Bold", size: 18)!
//        let descFont = UIFont(name: "HelveticaNeue", size: 14)!
//
//        let rocket  = UIImage(named: "rocket") as UIImage!  // implicitly unwrapped
//
//        return [OnboardingItemInfo(informationImage: rocket!, title: "Rocket1", description: "Lorem ipsum", pageIcon: rocket!, color: backgroundOne, titleColor: textColor, descriptionColor: textColor, titleFont: titleFont, descriptionFont: descFont),
//                OnboardingItemInfo(informationImage: rocket!, title: "Rocket2", description: "Dolor sit amet", pageIcon: rocket!, color: backgroundTwo, titleColor: textColor, descriptionColor: textColor, titleFont: titleFont, descriptionFont: descFont)][index]
//    }
//}
