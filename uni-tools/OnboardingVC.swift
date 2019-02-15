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
    
//    var window: UIWindow?
    
//    @IBOutlet var onboardingObj: OnboardingClass!
        
//    override func viewDidLoad() {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window!.backgroundColor = UIColor.white
//
//        self.generateOnboardingViewController()
//
//        self.window!.makeKeyAndVisible()
//    }
    var onboarded = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (onboarded) {
            print("onboarded")
            self.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "homeViewController")
                self.present(controller, animated: true, completion: nil)
            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "homeViewController")
//            self.present(controller, animated: true, completion: nil)
        }
        
        print("viewDidAppear")
        let onboardVC = generateOnboardingViewController()
        self.present(onboardVC, animated: true, completion: nil)
        print("presented")
    }
    
    func generateOnboardingViewController() -> OnboardingViewController{
        // Generate the first page...
        let firstPage: OnboardingContentViewController = OnboardingContentViewController(title: "What A Beautiful Photo", body: "This city background image is so beautiful", image: UIImage(named:
            "rocket"), buttonText: "Enable Location Services") {
        }
        
        // Generate the second page...
        let secondPage: OnboardingContentViewController = OnboardingContentViewController(title: "I'm So Sorry", body: "I can't get over the nice blurry background photo.", image: UIImage(named:
            "rocket"), buttonText: "Connect With Facebook") {
        }
        
        // Generate the third page, and when the user hits the button we want to handle that the onboarding
        // process has been completed.
        let thirdPage: OnboardingContentViewController = OnboardingContentViewController(title: "Seriously Though", body: "Kudos to the photographer.", image: UIImage(named:
            "rocket"), buttonText: "Let's Get Started") {
                self.onboarded = true
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let homeVC = storyboard.instantiateViewController(withIdentifier: "homeViewController")
//                self.presentingViewController(homeVC, animated: true, completion: nil)
        }
        
        // Create the onboarding controller with the pages and return it.
        let onboardingVC: OnboardingViewController = OnboardingViewController(backgroundImage: UIImage(named: "rocket"), contents: [firstPage, secondPage, thirdPage])
        
        print("returned")
        
        return onboardingVC
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
