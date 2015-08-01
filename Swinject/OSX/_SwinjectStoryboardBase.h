//
//  _SwinjectStoryboardBase.h
//  Swinject
//
//  Created by Yoichi Tagaya on 8/1/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface _SwinjectStoryboardBase : NSStoryboard

+ (nonnull instancetype)_create:(nonnull NSString *)name bundle:(nullable NSBundle *)storyboardBundleOrNil;

@end
