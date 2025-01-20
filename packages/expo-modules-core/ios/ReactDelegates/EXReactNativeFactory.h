// Copyright 2018-present 650 Industries. All rights reserved.

#pragma once

#import <ExpoModulesCore/Platform.h>
#import <ExpoModulesCore/RCTAppDelegateUmbrella.h>
#import <React-RCTAppDelegate/RCTReactNativeFactory.h>

NS_ASSUME_NONNULL_BEGIN

@class EXReactDelegate;

NS_SWIFT_NAME(ExpoReactNativeFactory)
@interface EXReactNativeFactory : RCTReactNativeFactory

@property (nonatomic, weak, nullable) EXReactDelegate *reactDelegate;

- (NSURL *)bundleURL;
- (BOOL)fabricEnabled;
- (BOOL)turboModuleEnabled;
- (BOOL)bridgelessEnabled;

/**
 Initializer for EXAppDelegateWrapper integration
 */
- (instancetype)initWithReactDelegate:(nullable EXReactDelegate *)reactDelegate
                        configuration:(RCTRootViewFactoryConfiguration *)configuration
           turboModuleManagerDelegate:(nullable id)turboModuleManagerDelegate;

/**
 Calls super `viewWithModuleName:initialProperties:launchOptions:` from `RCTRootViewFactory`.
 */
- (UIView *)superViewWithModuleName:(NSString *)moduleName
                  initialProperties:(NSDictionary *)initialProperties
                      launchOptions:(NSDictionary *)launchOptions;

@end


NS_ASSUME_NONNULL_END
