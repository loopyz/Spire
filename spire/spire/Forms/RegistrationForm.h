//
//  RegistrationForm.h
//  spire
//
//  Created by Lucy Guo on 7/27/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FXForms.h"
#import "PrivacyPolicyViewController.h"
#import "TermsViewController.h"


typedef NS_ENUM(NSInteger, Gender)
{
    GenderMale = 0,
    GenderFemale,
    GenderOther
};


typedef NS_OPTIONS(NSInteger, Interests)
{
    InterestComputers = 1 << 0,
    InterestSocializing = 1 << 1,
    InterestSports = 1 << 2
};


typedef NS_OPTIONS(NSInteger, ServicePlan)
{
    ServicePlanMicro = 0,
    ServicePlanNormal,
    ServicePlanMaxi
};


@interface RegistrationForm : NSObject <FXForm>

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *repeatPassword;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) NSDate *dateOfBirth;
@property (nonatomic, strong) UIImage *profilePhoto;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSArray *interests;
@property (nonatomic, assign) Interests otherInterests;
@property (nonatomic, copy) NSString *about;

@property (nonatomic, assign) ServicePlan plan;

@property (nonatomic, copy) NSString *notifications;
@property (nonatomic, readonly) PrivacyPolicyViewController *privacyPolicy;
@property (nonatomic, readonly) TermsViewController *termsAndConditions;

@property (nonatomic, assign) BOOL agreedToTerms;

@end
