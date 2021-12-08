# [Sendbird](https://sendbird.com) Local Caching for iOS (Swift)

[![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)](https://cocoapods.org/pods/SendBirdSDK)
[![Languages](https://img.shields.io/badge/Language-Objective--C%20%7C%20Swift-orange.svg)](https://github.com/sendbird/SendBird-iOS-Swift/)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-green.svg)](https://cocoapods.org/pods/SendBirdSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Commercial License](https://img.shields.io/badge/License-Commercial-brightgreen.svg)](https://github.com/sendbird/SendBird-iOS-Swift/blob/master/LICENSE)

## Table of contents

  1. [Introduction](#introduction)
  1. [Before getting started](#before-getting-started)
  1. [Getting started](#getting-started)
<br />

## Introduction

Local caching enables Sendbird Chat SDK for iOS to locally cache and retrieve group channel and message data. This facilitates offline messaging by allowing the SDK to create a channel list view or a chat view in a prompt manner and display them even when a client app is in offline mode. Provided here is a Local Caching for iOS sample to experience first-hand the benefits of Sendbird's Local Caching.


### More about Sendbird Local Caching for iOS

Find out more about Sendbird Local Caching for iOS on [Local Caching for iOS doc](https://sendbird.com/docs/chat/v3/ios/guides/local-caching). If you have any comments or questions regarding bugs and feature requests, visit [Sendbird community](https://community.sendbird.com). 

<br />

## Before getting started

This section shows you the prerequisites you need to check for using Sendbird Chat SDK for iOS.

### Requirements

The minimum requirements for Chat SDK for iOS are:

- iOS 9.0+
- [Chat SDK for iOS](https://github.com/sendbird/sendbird-ios-framework) 3.1.0 or higher

Try the sample app using your data
If you would like to try the sample app specifically fit to your usage, you can do so by replacing the default sample app ID with yours, which you can obtain by [creating your Sendbird application from the dashboard](https://sendbird.com/docs/chat/v3/ios/quickstart/send-first-message#2-step-1-create-a-sendbird-application-from-your-dashboard). Furthermore, you could also add data of your choice on the dashboard to test. This will allow you to experience the sample app with data from your Sendbird application.

## Getting started

This section gives you information you need to get started with Local Caching for iOS.

### Create a project

Create a project to get started: Sendbird SyncManager for iOS supports both Objective-C and Swift.

### Install SDK via CocoaPods or Carthage

Installing the Chat SDK is a simple process if you’re familiar with using external libraries or SDK’s in your projects. You can install the Chat SDK using [`CocoaPods`](https://cocoapods.org/) or [`Carthage`](https://github.com/Carthage/Carthage) like the following.

#### - CocoaPod

Open a terminal window. Navigate to the project directory, and then open the `Podfile` by running the following command:

```bash
$ pod init
```

On `Podfile`, add the following lines: 

```bash
platform :ios, '9.0'
use_frameworks!

target YOUR_PROJECT_TARGET do
    pod 'SendBirdSDK', '~> 3.1.0'
end
```

Install the `SendBird` framework through `CocoaPods`.

```bash
$ pod install
```

Now you can run your project with the `SendBird` framework by opening `*YOUR_PROJECT*.xcworkspace`. If you don't want to use `CocoaPods`, check out the [manual installation guide](https://help.sendbird.com/s/article/iOS-How-can-I-install-SendBird-Framework-without-using-CocoaPods).

#### - Carthage

1. Add `github "sendbird/sendbird-ios-framework"` to your `Cartfile`.
2. Run `carthage update`.
3. Go to your Xcode project's General settings tab. Open the `<YOUR_XCODE_PROJECT_DIRECTORY>/Carthage/Build/iOS` in the Finder window and drag `SendBirdSDK.framework` to the Embedded Binaries section in Xcode. Make sure the `Copy items if needed` option is selected and click `Finish`.
4. On your application targets’ Build Phases settings tab, click the **+** icon and choose **New Run Script Phase**. Create a **Run Script** in which you specify your shell (ex: /bin/sh), add the following contents to the script area below the shell: `/usr/local/bin/carthage copy-frameworks`
5. Add the paths to the frameworks you want to use under **Input Files**.  For example: `$(SRCROOT)/Carthage/Build/iOS/SendBirdSDK.framework`
6. Add the paths to the copied frameworks to the **Output Files**. For example: `$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/SendBirdSDK.framework`

For an in depth guide, read on from [Adding frameworks to an application](https://github.com/Carthage/Carthage#quick-start).
