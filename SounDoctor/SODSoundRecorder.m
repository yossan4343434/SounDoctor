//
//  SODSoundRecorder.m
//  SounDoctor
//
//  Created by Yoshiyuki Kuga on 2015/02/01.
//  Copyright (c) 2015年 SounDoctor. All rights reserved.
//

#import "SODSoundRecorder.h"

@implementation SODSoundRecorder

@synthesize queue, currentPacket, audioFile, isRecording;

static void AudioInputCallback(
                               void* inUserData,
                               AudioQueueRef inAQ,
                               AudioQueueBufferRef inBuffer,
                               const AudioTimeStamp *inStartTime,
                               UInt32 inNumberPacketDescriptions,
                               const AudioStreamPacketDescription *inPacketDescs)
{
    AudioRecorder* recorder = (__bridge SODSoundRecorder *) inUserData;
    
    OSStatus status = AudioFileWritePackets(
                                            recorder.audioFile,
                                            NO,
                                            inBuffer->mAudioDataByteSize,
                                            inPacketDescs,
                                            recorder.currentPacket,
                                            &inNumberPacketDescriptions,
                                            inBuffer->mAudioData);
    
    if (status == noErr) {
        recorder.currentPacket += inNumberPacketDescriptions;
        AudioQueueEnqueueBuffer(recorder.queue,inBuffer,0,nil);
    }
}

-(id) init
{
    isRecording = NO;
    dataFormat.mSampleRate = 44100.0f;
    dataFormat.mFormatID = kAudioFormatLinearPCM;
    dataFormat.mFramesPerPacket = 1;
    dataFormat.mChannelsPerFrame = 1;
    dataFormat.mBytesPerFrame = 2;
    dataFormat.mBytesPerPacket = 2;
    dataFormat.mBitsPerChannel = 16;
    dataFormat.mReserved = 0;
    dataFormat.mFormatFlags =
    kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    return self;
}

- (void) record {
    NSString *filePath = [NSString stringWithFormat:@"%@/hoge.aiff", DOCUMENTS_FOLDER, caldate];
    fileURL = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8 *)[filePath UTF8String], [filePath length], NO);
    
    currentPacket = 0;
    isRecording = YES;
    
    AudioQueueNewInput(&dataFormat,AudioInputCallback,self,CFRunLoopGetCurrent(),kCFRunLoopCommonModes,0,&queue);
    AudioFileCreateWithURL(fileURL, kAudioFileAIFFType, &dataFormat, kAudioFileFlags_EraseFile, &audioFile);
    
    UInt32 cookieSize;
    
    if (AudioQueueGetPropertySize (queue,kAudioQueueProperty_MagicCookie,&cookieSize) == noErr) {
        char* magicCookie = (char *) malloc (cookieSize);
        if (AudioQueueGetProperty (queue,kAudioQueueProperty_MagicCookie,magicCookie,&cookieSize) == noErr) {
            AudioFileSetProperty (audioFile,kAudioFilePropertyMagicCookieData,cookieSize,magicCookie);
        }
        free (magicCookie);
    }
    
    for(int i=0; i < NUM_BUFFERS; i++)
    {
        AudioQueueAllocateBuffer(queue,(dataFormat.mSampleRate/10.0f)*dataFormat.mBytesPerFrame,&buffers[i]);
        AudioQueueEnqueueBuffer(queue,buffers[i],0,nil);
    }
    
    AudioQueueStart(queue, NULL);
}

- (void) stop {
    isRecording = NO;
    AudioQueueFlush(queue);
    AudioQueueStop(queue, NO);
    
    for(int i = 0; i < NUM_BUFFERS; i++) {
        AudioQueueFreeBuffer(queue, buffers[i]);
    }
    
    AudioQueueDispose(queue, YES);
    AudioFileClose(audioFile);
}

@end