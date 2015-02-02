//
//  SODAudioRecorder.m
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/02/01.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import "SODAudioRecorder.h"

@implementation SODAudioRecorder

- (void)startRecord:(id)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *error = nil;
    if ([audioSession inputIsAvailable]) {
        [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    }
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }

    [audioSession setActive:YES error:&error];
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:nil error:&error];
    
    if(error){
        NSLog(@"error = %@",error);
        return;
    }
    recorder.delegate=self;
    [recorder recordForDuration: 5.0];
}

- (void)play:(id)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
    player.delegate = self;
    player.volume=1.0;
    [player play];
}

@end
