//
//  _SwinjectStoryboardBase.h
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/// The base class of `SwinjectStoryboard`, which should not be used directly in your app.
@interface _SwinjectStoryboardBase : NSStoryboard

/// The factory method, which should not be used directly in your app.
+ (nonnull instancetype)_create:(nonnull NSString *)name bundle:(nullable NSBundle *)storyboardBundleOrNil;

@end
