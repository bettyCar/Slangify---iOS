//
//  SLNLoginViewController.swift
//  Slangify
//
//  Created by Betty Kintzlinger on 11/03/2017.
//  Copyright © 2017 Geemodity. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class SLNLoginViewController: UIViewController {
    
    fileprivate let challengeSegue : String = "Start"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FBSDKAccessToken.current() != nil {
            loginWithFireBase()
        }
    }
}

extension SLNLoginViewController {
    func setupView() {
        GradientColorDispatcher.setGradient(toView: self.view)
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton)
    }
    
    @IBAction func didTapTakeChallenge() {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil { return }
            self.performSegue(withIdentifier: self.challengeSegue, sender: nil)
        })
    }
}

extension SLNLoginViewController : FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil { return }
        self.loginWithFireBase()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginWithFireBase() {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil { return }
            self.performSegue(withIdentifier: self.challengeSegue, sender: nil)
        }
    }
}
