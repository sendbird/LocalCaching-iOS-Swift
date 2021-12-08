//
//  SceneDelegate.swift
//  SendBird-iOS
//
//  Created by Jaesung Lee on 23/08/2019.
//  Copyright © 2019 SendBird. All rights reserved.
//

import UIKit
import UserNotifications
import SendBirdSDK
import AVKit
import AVFoundation
import Alamofire
import AlamofireImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var identifier: String?
    
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        self.window = UIWindow(windowScene: windowScene)
//
//        if let window = self.window {
//            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
//            window.rootViewController = viewController
//            window.makeKeyAndVisible()
//            identifier = session.persistentIdentifier
//        }
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) { }
}

