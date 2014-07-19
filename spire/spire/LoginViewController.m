//
//  LoginViewController.m
//  spire
//
//  Created by Lucy Guo on 7/19/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//
#import <Parse/Parse.h>

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RegisterInformationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // moved to view did load temporarily
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    // check if user is cached and linked to Facebook and bypass login if so
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        //[PFUser logOut];
        HomeViewController *svc = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
        return;
    }
    
    // otherwise do login
    [self addBackgroundImage];
    [self addLogo];
    
	// Do any additional setup after loading the view.
    [self setupFacebookLogin];
    [self setupNormalLogin];
    [self setupRegisterButton];
    
}

- (void)buttonTouched:(id)sender
{
    NSArray *permissionsArray = @[@"user_about_me", @"user_friends"];
    // login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"User cancelled the FB Login Process.");
            } else {
                NSLog(@"Some error occured during FB Login Process.");
            }
        } else if (user.isNew || ![user objectForKey:@"registered"]) {
            NSLog(@"User just joined the app. Successful login.");
            RegisterInformationViewController *svc = [[RegisterInformationViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
//            HomeViewController *svc = [[HomeViewController alloc] init];
//            [self.navigationController pushViewController:svc animated:YES];
        } else {
            NSLog(@"Successful login.");
            HomeViewController *svc = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
    }];
    
    HomeViewController *svc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)normalLoginTouched
{
    //lol we'll have this later
}

#pragma mark - Button Setup

- (void)setupRegisterButton
{
    // Do any additional setup after loading the view.
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.facebookButton.frame = CGRectMake((self.view.frame.size.width - 278)/2 + 3, 495, 278, 41);
    [self.facebookButton addTarget:self action:@selector(normalLoginTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"email-register.png"];
    [self.facebookButton setImage:btnImage forState:UIControlStateNormal];
    self.facebookButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.facebookButton];
}

- (void)setupNormalLogin
{
    // Do any additional setup after loading the view.
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.facebookButton.frame = CGRectMake((self.view.frame.size.width - 278)/2 + 3, 445, 278, 41);
    [self.facebookButton addTarget:self action:@selector(normalLoginTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"email-login.png"];
    [self.facebookButton setImage:btnImage forState:UIControlStateNormal];
    self.facebookButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.facebookButton];
}

- (void)setupFacebookLogin
{
    // Do any additional setup after loading the view.
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.facebookButton.frame = CGRectMake((self.view.frame.size.width - 278)/2 + 3, 395, 278, 41);
    [self.facebookButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"facebook-login.png"];
    [self.facebookButton setImage:btnImage forState:UIControlStateNormal];
    self.facebookButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.facebookButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}

#pragma mark - View Setup

- (void)addBackgroundImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"login-bg.png"];
    
    [self.view insertSubview:imageView atIndex:0];
}

- (void)addLogo
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 230)/2, 50, 423/2, 231/2)];
    imgView.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:imgView];
}

@end