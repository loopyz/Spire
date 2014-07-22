//
//  Util.h
//  spire
//
//  Created by Ivan Wang on 7/21/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import <Parse/Parse.h>

@interface Util : NSObject

+ (BOOL)screenIsPortrait;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (NSString *)currentUserId;
+ (void)currentPetWithBlock:(void (^)(PFObject *pet, NSError *error))callback;
//+ (BOOL)currentUserHasPet;

@end
