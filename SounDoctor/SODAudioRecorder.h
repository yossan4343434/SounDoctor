//
//  SODAudioRecorder.h
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/02/01.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SODAudioRecorder : NSObject

@property (nonatomic, retain) AVAudioSession *session;
@property (nonatomic, retain) AVAudioRecorder *recorder;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSArray *filePaths;
@property (nonatomic, retain) NSString *documentDir;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSURL *recordingURL;

- (void)startRecord;
- (void)stopAudio:(id)sender;
- (void)playAudioFile;
- (void)openAudioFileWithUrl:(NSURL *)url;
- (void)deleteAudioFileWithPath;
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag;

@end
