//
//  _SwinjectStoryboardBase.h
//  Swinject
//
//  Created by Yoichi Tagaya on 8/2/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _SwinjectStoryboardBase : UIStoryboard

+ (nonnull instancetype)_create:(nonnull NSString *)name bundle:(nullable NSBundle *)storyboardBundleOrNil;

@end
