//
//  CreateGroupChannelViewControllerDelegate.swift
//  SendBird-iOS
//
//  Created by Jed Gyeong on 10/15/18.
//  Copyright © 2018 SendBird. All rights reserved.
//

import Foundation
import SendBirdSDK

protocol CreateGroupChannelViewControllerDelegate: NSObjectProtocol {
    func didCreateGroupChannel(_ channel: SBDGroupChannel)
}
