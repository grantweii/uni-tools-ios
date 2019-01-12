//
//  ViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 7/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "showHome", sender: self)
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
                self.performSegue(withIdentifier: "showHome", sender: self)
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
                self.createAlert(title: "Signup Error", message: displayErrorMessage)
            } else {
                print("user signed up")
                self.performSegue(withIdentifier: "showHome", sender: self)
            }
        }
    }
    
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

