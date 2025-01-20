// Copyright 2018-present 650 Industries. All rights reserved.

#import <ExpoModulesCore/EXReactNativeFactory.h>
#import <ExpoModulesCore/EXReactDelegateWrapper+Private.h>
#import <ExpoModulesCore/RCTAppDelegateUmbrella.h>
#import <ExpoModulesCore/Swift.h>
#import <ExpoModulesCore/EXReactRootViewFactory.h>
 


@implementation EXReactNativeFactory

- (instancetype)initWithReactDelegate:(nullable EXReactDelegate *)reactDelegate
                        configuration:(RCTRootViewFactoryConfiguration *)configuration
           turboModuleManagerDelegate:(nullable id<RCTTurboModuleManagerDelegate>)turboModuleManagerDelegate
{
  
  self.reactDelegate = reactDelegate;

  return self;
}

- (RCTRootViewFactory *)createRCTRootViewFactory
{
  __weak __typeof(self) weakSelf = self;
  RCTBundleURLBlock bundleUrlBlock = ^{
    auto *strongSelf = weakSelf;
    return strongSelf.bundleURL;
  };
  
  RCTRootViewFactoryConfiguration *configuration =
  [[RCTRootViewFactoryConfiguration alloc] initWithBundleURLBlock:bundleUrlBlock
                                                   newArchEnabled:self.fabricEnabled
                                               turboModuleEnabled:self.turboModuleEnabled
                                                bridgelessEnabled:self.bridgelessEnabled];
  
  configuration.createRootViewWithBridge = ^UIView *(RCTBridge *bridge, NSString *moduleName, NSDictionary *initProps) {
    return [weakSelf.delegate createRootViewWithBridge:bridge moduleName:moduleName initProps:initProps];
  };
  
  configuration.createBridgeWithDelegate = ^RCTBridge *(id<RCTBridgeDelegate> delegate, NSDictionary *launchOptions) {
    return [weakSelf.delegate createBridgeWithDelegate:delegate launchOptions:launchOptions];
  };
  
  configuration.customizeRootView = ^(UIView *_Nonnull rootView) {
    [weakSelf.delegate customizeRootView:(RCTRootView *)rootView];
  };
  
  configuration.sourceURLForBridge = ^NSURL *_Nullable(RCTBridge *_Nonnull bridge)
  {
    return [weakSelf.delegate sourceURLForBridge:bridge];
  };
  
  if ([self.delegate respondsToSelector:@selector(extraModulesForBridge:)]) {
    configuration.extraModulesForBridge = ^NSArray<id<RCTBridgeModule>> *_Nonnull(RCTBridge *_Nonnull bridge)
    {
      return [weakSelf.delegate extraModulesForBridge:bridge];
    };
  }
  
  if ([self.delegate respondsToSelector:@selector(extraLazyModuleClassesForBridge:)]) {
    configuration.extraLazyModuleClassesForBridge =
    ^NSDictionary<NSString *, Class> *_Nonnull(RCTBridge *_Nonnull bridge)
    {
      return [weakSelf.delegate extraLazyModuleClassesForBridge:bridge];
    };
  }
  
  if ([self.delegate respondsToSelector:@selector(bridge:didNotFindModule:)]) {
    configuration.bridgeDidNotFindModule = ^BOOL(RCTBridge *_Nonnull bridge, NSString *_Nonnull moduleName) {
      return [weakSelf.delegate bridge:bridge didNotFindModule:moduleName];
    };
  }
  
  return [[EXReactRootViewFactory alloc] initWithTurboModuleDelegate:self hostDelegate:self configuration:configuration];
}

@end
