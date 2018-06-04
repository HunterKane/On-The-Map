//
//  LoginViewController.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/18/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//
import FacebookLogin
import FacebookCore
import SafariServices
import UIKit


class LoginViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self 
        keyboardYLimit.buttonY = (loginButton?.frame.origin.y)! + self.view.frame.origin.y / self.view.frame.origin.y
    }
    
    //Keybaord
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
    }
    //Keyboard
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func userTappedScreen( _sender: AnyObject) {
        resignIfFirstResponder(userNameTextField)
        resignIfFirstResponder(passwordTextField)
        
    }
    //Action
    @IBAction func loginPressed( _sender: Any) {
        userTappedScreen(_sender: self)
        
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.showAlert(text:"Error: Username or Password missing")
        } else {
            self.view.showBlurLoader()
            getSessionId()
            
        }
    }
    
    //Take user to Udacity sign up page
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let app = UIApplication.shared
        let toOpen = "https://www.udacity.com/account/auth#!/signup"
        app.open(URL(string: toOpen)!, options: [:], completionHandler: { (success) in
            if success == false {
                print("FAIL TO OPEN URL")
                return
            }})
    }
    
    //verify user with session Id
    func getSessionId() {
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        UdacityClient.sharedInstance().postToGetSessionID(userName: userName!, password: password!) { (success, error) in
            if let error = error {
                print("There was an error at postToGetSessionID: \(error)")
                self.showAlert(text:error.localizedDescription)
            }
            else if success {
                print ("Logged in!!")
                self.presentMapAndTableTabbedView()
            }
            self.view.removeBlurLoader()
        }
    }
    
    //MARK: Facebook func proceedure
    @IBAction func facebookLoginPressed(_ sender: Any) {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userFriends], viewController: self) {(loginResult) in
          //Create switch to handle errors
            switch
                loginResult {
         
            case .failed(let error):
                print(error)
                
            case .cancelled:
                print("The user cancels login")
                
            case .success(grantedPermissions: let granted, declinedPermissions: let declined, token: let tokens):
                
                print(granted, declined, tokens)
                print("user logged in")
                
            }
            //If successful then present MapAndTableTabbedView VC
            self.presentMapAndTableTabbedView()
        }
       
    }
    
    
    // MARK: Navigation to MapAndTableTabbedView
    func presentMapAndTableTabbedView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapAndTableTabbedView") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
}
