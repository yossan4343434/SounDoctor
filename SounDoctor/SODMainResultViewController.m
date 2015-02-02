//
//  SODMainResultViewController.m
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/01/31.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import "SODMainResultViewController.h"
#import "SODTabBarController.h"
#import "SODAudioRecorder.h"

@interface SODMainResultViewController ()

@property (nonatomic) SODAudioRecorder *recorder;

@end

@implementation SODMainResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupButton];
    self.recorder = [[SODAudioRecorder alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupButton
{
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveSound)];
    [self.navigationItem setRightBarButtonItem:saveButton];
}

#pragma mark - Save

- (void)saveSound
{
    SODTabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"SODTabBarController"];
    [self presentViewController:tbc animated:YES completion:nil];
}
- (IBAction)showDetail:(UIButton *)sender {
    [self.recorder startRecord:(id)sender];
}
- (IBAction)callDoctor:(UIButton *)sender
{
    [self.recorder play:(id)sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
