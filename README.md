# Set up Development for kintone iOS SDK

[![Swift Version](https://img.shields.io/badge/Swift-4.0.x-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/cocoapods/p/FacebookCore.svg)](https://cocoapods.org/pods/FacebookCore)
[![Build Status](https://travis-ci.org/facebook/facebook-sdk-swift.svg?branch=master)](https://travis-ci.org/facebook/facebook-sdk-swift)


Swift-taylored experience to integrate your app with Kintone. Including:

- [Application](https://developer.kintone.io/hc/en-us/articles/360008719854) - Support REST API to manage applications to kintone.
- [Record](https://developer.kintone.io/hc/en-us/articles/360008719854) - Support REST API to Get/Add/Update/Delete with records from a kintone application.
- [File](https://developer.kintone.io/hc/en-us/articles/360008719854) - Support REST API to upload/download file to kintone.
- [Bulk Request](https://developer.kintone.io/hc/en-us/articles/360008719854) - Support REST API to send bulk request to kintone.

**NOTE:** This SDK is currently in Beta and may be unstable at times. 

## Overview
- Kintone iOS SDK is using [google promises](https://github.com/google/promises) as dependencies frameworks

### System Requirements
- Install [CocoaPods](https://cocoapods.org) or [Carthage](https://github.com/carthage/carthage)

## How to install
### Preparation for install Cocoapods or Carthage
- Install homebrew

```bash
/usr/bin/ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'
```
- Set up Command Line Tools in Xcode > Preferences > Locations

![Command Line Tool](https://raw.githubusercontent.com/kintone/kintone-ios-sdk/master/images/command-line-tools.png)

### CocoaPods

Make sure you are running the latest version of [CocoaPods](https://cocoapods.org) by running:

```bash
gem install cocoapods

# (or if the above fails)
sudo gem install cocoapods
```

**Note:** We support any version of CocoaPods 1.0.1 or later.

Update your local specs repo by running:

```bash
pod repo update
```

**Note:** This step is optional, if you updated the specs repo recently.

Add the following lines to your Podfile:

```ruby
pod 'PromisesSwift', '~> 1.2.4'
```

Run `pod install` and you're all set!

You may also exclude any of these dependencies, if you do not need the features of those parts of the SDK.

### Carthage

Make sure you are running the latest version of [Carthage](https://github.com/carthage/carthage) by running:

```bash
brew update
brew upgrade carthage
```

**Note:** We recommend using Carthage version 0.31.1 or later.

Add the following line to your Cartfile:

```bash
github "google/promises"
```

Run `carthage update`.

**Note:** This will fetch dependencies into a `Carthage/Checkouts` folder, then build each one.

On your application targets' `General` settings tab, in the `Linked Frameworks and Libraries` section.

At a minimum, you'll need to drag & drop the following frameworks from `Carthage/Build/iOS` folder on disk:

- `FBLPromises.framework`
- `Promises.framework`


### Optional
On your application targets' `Build Phases` tab:

- Click `+` icon and choose `New Run Script Phase`.
- Create a script with a shell of your choice (e.g. `/bin/sh`).
- Add the following to the script area below the shell:

```bash
/usr/local/bin/carthage copy-frameworks
```

- Add the paths to the frameworks you want to use under `Input Files`, for example:

```bash
$(SRCROOT)/Carthage/Build/iOS/FBLPromises.framework
$(SRCROOT)/Carthage/Build/iOS/Promises.framework
```

## Contribute

All of Kintone iOS SDK for Swift development happens on GitHub. 
