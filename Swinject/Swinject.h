//
//  Swinject.h
//  Swinject
//
//  Created by Yoichi Tagaya on 7/22/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for Swinject.
FOUNDATION_EXPORT double SwinjectVersionNumber;

//! Project version string for Swinject.
FOUNDATION_EXPORT const unsigned char SwinjectVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Swinject/PublicHeader.h>


// TARGET_OS_MAC includes iOS, watchOS and tvOS, so TARGET_OS_MAC must be evaluated after them.
#if TARGET_OS_IOS || TARGET_OS_TV || (!TARGET_OS_WATCH && TARGET_OS_MAC)

#import <Swinject/_SwinjectStoryboardBase.h>

#endif
