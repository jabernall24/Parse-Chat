//
//  LogInViewController.swift
//  Parse chat
//
//  Created by Jesus Andres Bernal Lopez on 9/29/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func onSignUp(_ sender: Any) {
        self.activityIndicator.startAnimating()
        let newUser = PFUser()
        
        newUser.username = self.usernameTextField.text
        newUser.password = self.passwordTextField.text
        
        if usernameTextField.text == "" || passwordTextField.text == ""{
            self.alertUser(title: "Both username and password are required", message: "Please fill both in to sign up.")
            return
        }
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success{
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "LogInSegue", sender: nil)
            }else{
                self.activityIndicator.stopAnimating()
                self.alertUser(error: error)
            }
        }
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        self.activityIndicator.startAnimating()
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if error == nil{
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "LogInSegue", sender: nil)
            }else{
                self.activityIndicator.stopAnimating()
                self.alertUser(error: error)
            }
        }
    }

    func alertUser(error: Error?){
        let alertController = UIAlertController(title: error?.localizedDescription, message: "Please fix and try again", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        self.present(alertController, animated: true)
    }
    
    func alertUser(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        self.present(alertController, animated: true)
    }
}
