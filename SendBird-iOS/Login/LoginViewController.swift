//
//  LoginViewController.swift
//  SendBird-iOS
//
//  Created by Jed Gyeong on 10/3/18.
//  Copyright © 2018 SendBird. All rights reserved.
//

import UIKit
import SendBirdSDK
import Photos

class LoginViewController: UIViewController, UITextFieldDelegate, NotificationDelegate {
    
    private var keyboardShown: Bool = false
    private var logoChanged: Bool = false
    private var logoInvisble: Bool = false
    
    @IBOutlet weak var connectButton: CustomButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nicknameTextField: CustomTextField!
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet weak var userIdLabelTop: NSLayoutConstraint!
    @IBOutlet weak var userIdTextField: CustomTextField!
    @IBOutlet weak var versionInfoLabel: UILabel!
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        ConnectionManager.login { (user, error) in
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        let contentViewTapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(LoginViewController.tapContentView))
        
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(contentViewTapRecognizer)
        
        self.userIdTextField.delegate = self
        self.nicknameTextField.delegate = self
        
        self.setupUI()
    }
    
    func setupUI() {
        if let userId = UserDefaults.standard.object(forKey: "sendbird_user_id") as? String {
            self.userIdTextField.text = userId
        }
        if let nickname = UserDefaults.standard.object(forKey: "sendbird_user_nickname") as? String {
            self.nicknameTextField.text = nickname
        }
        
        // Version
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"){
            if let infoDict = NSDictionary.init(contentsOfFile: path), let sampleUIVersion = infoDict["CFBundleShortVersionString"] as? String {
                let version = "Sample UI v\(sampleUIVersion) / SDK v\(SBDMain.getSDKVersion())"
                self.versionInfoLabel.text = version
            }
        }
        
//        let authStatus = PHPhotoLibrary.authorizationStatus()
//        if authStatus != PHAuthorizationStatus.authorized {
//            PHPhotoLibrary.requestAuthorization { (status) in
//                
//            }
//        }
        
        let autoLogin = UserDefaults.standard.bool(forKey: "sendbird_auto_login")
        if autoLogin {
            self.connect()
        }
    }
    
    // MARK: - Keyboard
    // Show
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameBegin = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else  { return }
        let keyboardFrameBeginRect = keyboardFrameBegin.cgRectValue
        
        if !self.keyboardShown {
            let distanceFromBottom = self.view.frame.height - self.connectButton.frame.maxY
            if distanceFromBottom <= keyboardFrameBeginRect.size.height + 90 {
                animateUI(keyboardFrameBeginRect.size.height)
            }
        }
        self.keyboardShown = true
    }
    
    // Hide
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.keyboardShown && logoInvisble {
            animateUI(0)
        }
        self.keyboardShown = false
    }
    
    // Disable
    @objc func tapContentView() {
        if self.keyboardShown == true {
            self.view.endEditing(true)
        }
    }
    
    // MARK: - IBAction
    @IBAction func didTapConnectButton() {
        self.connect()
    }
    
    // MARK: - Functions
    // Animation during showing / hiding keyboard
    func animateUI(_ scrollValue: CGFloat) {
        self.view.layoutIfNeeded()
        self.scrollViewBottom.constant = scrollValue
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.userIdLabelTop.constant = !self.keyboardShown ? 23 : 56
            self.view.layoutIfNeeded()
            self.versionInfoLabel.alpha = self.keyboardShown ? 1 : 0
        }
        animator.startAnimation()
        logoInvisble = !logoInvisble
    }
    
    
    func connect() {
        self.view.endEditing(true)
        if SBDMain.getConnectState() == .open {
            SBDMain.disconnect {
                DispatchQueue.main.async {
                    self.setUIsForDefault()
                }
            }
        }
        else {
            let userId = self.userIdTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let nickname = self.nicknameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            guard let id = userId, let nick = nickname else {
                Utils.showAlertController(title: "Error", message: "User ID and Nickname are required.", viewController: self)
                
                return
            }
            
            let userDefault = UserDefaults.standard
            userDefault.setValue(userId, forKey: "sendbird_user_id")
            userDefault.setValue(nickname, forKey: "sendbird_user_nickname")
            
            self.setUIsWhileConnecting()
            
            ConnectionManager.login(userId: id, nickname: nick) { user, error in
                guard user != nil else {
                    DispatchQueue.main.async {
                        self.setUIsForDefault()
                    }
                    
                    if let error = error {
                        Utils.showAlertController(error: SBDError.init(nsError: error), viewController: self)
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    self.setUIsForDefault()
                    
                    self.performSegue(withIdentifier: "LoggedIn", sender: self)
                }
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userIdTextField {
            textField.resignFirstResponder()
            self.nicknameTextField.becomeFirstResponder()
        } else {
            self.connect()
        }
        
        return true
    }

    
    // MARK: - NotificationDelegate
    func openChat(_ channelUrl: String) {
        self.navigationController?.popViewController(animated: false)
        let tabBarVC = MainTabBarController.init(nibName: "MainTabBarController", bundle: nil)
        self.present(tabBarVC, animated: false) {
            let vc = UIViewController.currentViewController()
            if vc is GroupChannelsViewController {
                (vc as! GroupChannelsViewController).openChat(channelUrl)
            }
        }
    }
    
    private func setUIsWhileConnecting() {
        self.userIdTextField.isEnabled = false
        self.nicknameTextField.isEnabled = false
        self.connectButton.isEnabled = false
        self.connectButton.setTitle("Connecting...", for: .normal)
    }
    
    private func setUIsForDefault() {
        self.userIdTextField.isEnabled = true
        self.nicknameTextField.isEnabled = true
        self.connectButton.isEnabled = true
        self.connectButton.setTitle("Connect", for: .normal)
    }
}
