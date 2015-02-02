//
//  SODCourseDiagnoseViewController.m
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/01/30.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "SODCourseDiagnoseViewController.h"
#import "SODDiagnoseViewController.h"
#import "SODMainResultViewController.h"

@interface SODCourseDiagnoseViewController ()

@end

@implementation SODCourseDiagnoseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupButton];
    [self performSelector:@selector(showMainResult) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup

- (void)setupButton
{
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelDiagnose)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
}

#pragma mark - segue

-(void)cancelDiagnose
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMainResult
{
    [self performSegueWithIdentifier:@"showMainResult" sender:self];
}

@end
