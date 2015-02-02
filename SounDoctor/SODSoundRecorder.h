//
//  SODSoundRecorder.h
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/02/01.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioFile.h>

#define NUM_BUFFERS 3
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface SODSoundRecorder : NSObject
{
    AudioFileID audioFile;
    AudioStreamBasicDescription dataFormat;
    AudioQueueRef queue;
    AudioQueueBufferRef buffers[NUM_BUFFERS];
    CFURLRef fileURL;
    SInt64 currentPacket;
    BOOL isRecording;
}

@property AudioQueueRef queue;
@property SInt64 currentPacket;
@property AudioFileID audioFile;
@property BOOL isRecording;

- (id) init;
- (void) record;
- (void) stop;

static void AudioInputCallback(
                               void* inUserData,
                               AudioQueueRef inAQ,
                               AudioQueueBufferRef inBuffer,
                               const AudioTimeStamp *inStartTime,
                               UInt32 inNumberPacketDescriptions,
                               const AudioStreamPacketDescription *inPacketDescs
                               );

@end