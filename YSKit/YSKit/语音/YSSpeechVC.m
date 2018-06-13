//
//  YSSpeechVC.m
//  YSKit
//
//  Created by Bob on 2017/11/27.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "YSSpeechVC.h"
#import <Speech/Speech.h>

@interface YSSpeechVC ()
<
SFSpeechRecognizerDelegate
>

/**
 语音输入请求
 */
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *speechRequest;


/**
 当前识别进程
 */
@property (nonatomic, strong) SFSpeechRecognitionTask *currentSpeechTask;

/**
 声音处理
 */
@property (nonatomic, strong) AVAudioEngine          *audioEngine;

/**
 声音识别
 */
@property (nonatomic ,strong) SFSpeechRecognizer      *speechRecognizer;


/**
 显示结果
 */
@property (nonatomic, strong) UILabel *showLb;

/**
 开始识别
 */
@property (nonatomic, strong) UIButton *startBtn;

/**
 处理输入内容
 */
@property (nonatomic, strong) UIButton *openBtn;

@end

@implementation YSSpeechVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    if (@available(iOS 10.0, *)) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    break;
                default:
                    break;
                    
            }
        }];
    } else {
        // Fallback on earlier versions
    }
    
    self.startBtn.enabled = NO;
    self.audioEngine = [AVAudioEngine new];
    if (@available(iOS 10.0, *)) {
        self.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:
                                 [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    } else {
        // Fallback on earlier versions
    }
    self.speechRecognizer.delegate = self;
    
    // 初始化语音处理器的输入模式
    [self.audioEngine.inputNode installTapOnBus:0
                                     bufferSize:1024
                                         format:[self.audioEngine.inputNode outputFormatForBus:0]
                                          block:^(AVAudioPCMBuffer * _Nonnull buffer,AVAudioTime * _Nonnull when)
     {
         // 为语音识别请求对象添加一个AudioPCMBuffer，来获取声音数据
         [self.speechRequest appendAudioPCMBuffer:buffer];
         
     }];
    
    // 语音处理器准备就绪（会为一些audioEngine启动时所必须的资源开辟内存）
    [self.audioEngine prepare];
    
    self.startBtn.enabled = YES;
    self.openBtn.enabled = YES;
}


- (void)onStartBtnClicked
{
    if (@available(iOS 10.0, *)) {
        if (self.currentSpeechTask.state == SFSpeechRecognitionTaskStateRunning){  // 如果当前进程状态是进行中
            [self.startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
            // 停止语音识别
            [self stopDictating];
        }else {  // 进程状态不在进行中
            [self.startBtn setTitle:@"停止录制" forState:UIControlStateNormal];
            self.showLb.text = @"等待....";
            // 开启语音识别
            [self startDictating];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)startDictating
{
    NSError *error;
    
    // 启动声音处理器
    [self.audioEngine startAndReturnError: &error];
    
    // 初始化
    if (@available(iOS 10.0, *)) {
        self.speechRequest = [SFSpeechAudioBufferRecognitionRequest new];
    } else {
        // Fallback on earlier versions
    }
    
    // 使用speechRequest请求进行识别
    if (@available(iOS 10.0, *)) {
        self.currentSpeechTask =
        [self.speechRecognizer recognitionTaskWithRequest:self.speechRequest
                                            resultHandler:^(SFSpeechRecognitionResult * _Nullable result,NSError * _Nullable error)
         {
             // 识别结果，识别后的操作
             if (result == NULL) return;
             self.showLb.text = result.bestTranscription.formattedString;
         }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)stopDictating
{
    // 停止声音处理器，停止语音识别请求进程
    [self.audioEngine stop];
    [self.speechRequest endAudio];
}

- (void)dealWithMsg
{
    
}

#pragma mark --
#pragma mark lazy load
- (UILabel *)showLb
{
    if (!_showLb) {
        _showLb = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, self.view.bounds.size.width - 100, 100)];
        _showLb.numberOfLines = 0;
        _showLb.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _showLb.text = @"等待中...";
        _showLb.adjustsFontForContentSizeCategory = YES;
        _showLb.textColor = [UIColor orangeColor];
        [self.view addSubview:_showLb];
    }
    return _showLb;
}

- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame = CGRectMake(50, 80, 80, 80);
        [_startBtn addTarget:self
                      action:@selector(onStartBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setBackgroundColor:[UIColor redColor]];
        [_startBtn setTitle:@"录音" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_startBtn];
    }
    return _startBtn;
}


- (UIButton *)openBtn
{
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat originX = [UIScreen mainScreen].bounds.size.width/2;
        _openBtn.frame = CGRectMake(originX, 80, 80, 80);
        [_openBtn addTarget:self
                     action:@selector(dealWithMsg)
           forControlEvents:UIControlEventTouchUpInside];
        [_openBtn setBackgroundColor:[UIColor redColor]];
        [_openBtn setTitle:@"下单" forState:UIControlStateNormal];
        [_openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_openBtn];
    }
    return _openBtn;
}

@end
