//
//  SODAudioRecorder.m
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/02/01.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import "SODAudioRecorder.h"

@implementation SODAudioRecorder

- (void)setup
{
    _session = [AVAudioSession sharedInstance];
    if ([_session inputIsAvailable]) {
        [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    
    [_session setActive:YES error:nil];
    
    _filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    _documentDir = [_filePaths objectAtIndex:0];
    _path = [_documentDir stringByAppendingPathComponent:@"rec.caf"];
    _recordingURL = [NSURL fileURLWithPath:_path];
}

- (void)startRecord
{
    [self setup];
    _recorder = [[AVAudioRecorder alloc] initWithURL:_recordingURL settings:nil error:nil];
    [_recorder recordForDuration:5.0];
    NSLog(@"starRecord");
}

- (void)playAudioFile
{
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recordingURL error:nil];
    _player.volume = 1.0;
    [_player play];
    NSLog(@"playAudioFile");
}

@end
