//
//  ViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 7/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
import Parse
import Onboard

class ViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        print("VC viewdidappear")
        if PFUser.current() != nil {
            DispatchQueue.main.async {
                self.navigateToHome()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginClicked(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error", message: "Please enter a username and password")
        }
        
        let user = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in

                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()

            if error != nil {
                var displayErrorMessage = "Please try again"
                if let errorMessage = (error! as NSError).userInfo["error"] as? String {
                    displayErrorMessage = errorMessage
                }
                self.createAlert(title: "Login Error", message: displayErrorMessage)
            } else {
                print("user logged in")
                self.navigateToHome()
            }
        })
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error", message: "Please enter a username and password")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 70))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
        let user = PFUser()
        user.username = emailTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                var displayErrorMessage = "Please try again"
                if let errorMessage = (error! as NSError).userInfo["error"] as? String {
                    displayErrorMessage = errorMessage
                }
                print("error")
                self.createAlert(title: "Signup Error", message: displayErrorMessage)
            } else {
                print("user signed up")
                let onboardVC = self.generateOnboardingViewController()
                self.present(onboardVC, animated: true, completion: nil)
            }
        }
    }
    
    func navigateToHome() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController")
        self.present(homeViewController, animated: true, completion: nil)
//        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
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
                self.dismiss(animated: true, completion: nil)
        }
        
        // Create the onboarding controller with the pages and return it.
        let onboardingVC: OnboardingViewController = OnboardingViewController(backgroundImage: UIImage(named: "rocket"), contents: [firstPage, secondPage, thirdPage])
        
        print("returned")
        
        return onboardingVC
    }
    
}

