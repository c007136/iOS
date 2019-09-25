//
//  BaiduViewController.m
//  AVCapture
//
//  Created by muyu on 2019/9/16.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "BaiduViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MCCategory/UIView+MCFrame.h>
#import "UIViewController+KKAuthorization.h"
#import <IDLFaceSDK/IDLFaceSDK.h>
#import <ZBToastHUD/UIViewController+ZBToastHUD.h>
#import "FaceParameterConfig.h"

@interface BaiduViewController ()
<
AVCaptureMetadataOutputObjectsDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate
>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) UIImageView *imageOutputView;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) dispatch_queue_t captureQueue;
@property (nonatomic, strong) CIDetector *faceDetector;

@property (nonatomic, assign) BOOL hasFinished;
@property (nonatomic, assign) BOOL isSessionBegin;

@end

@implementation BaiduViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self kk_checkCameraAvailability:^(BOOL auth) {
        if (auth) {
            [self startCapture2];
        }
    }];
    
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:200];
    
    // 设置截取人脸图片大小
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
    
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
    
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:40];
    
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.7];
    
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
    
    // 设置是否进行人脸图片质量检测
    [[FaceSDKManager sharedInstance] setIsCheckQuality:YES];
    
    // 设置超时时间
    [[FaceSDKManager sharedInstance] setConditionTimeout:10];
    
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
    
    // 设置照片采集张数
    [[FaceSDKManager sharedInstance] setMaxCropImageNum:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hasFinished = NO;
    [[IDLFaceLivenessManager sharedInstance] startInitial];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hasFinished = YES;
    [IDLFaceLivenessManager.sharedInstance reset];
}

- (void)startCapture2
{
    self.isSessionBegin = YES;
    
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    if ([self.session canAddInput:self.deviceInput]) {
        [self.session addInput:self.deviceInput];
    }
    if ([self.session canAddOutput:self.videoOutput]) {
        [self.session addOutput:self.videoOutput];
    }
    
//    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
//    self.preview.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
//    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    CGFloat width = self.view.width/2;
//    self.preview.frame = CGRectMake(width/2, 100, width, width);
//    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    CGFloat scaleValue = 0.7;
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGRect detectRect = CGRectMake(screenWidth*(1-scaleValue)/2.0, screenHeight*(1-scaleValue)/2.0, screenWidth*scaleValue, screenHeight*scaleValue);
    self.imageOutputView.frame = detectRect;
    [self.view addSubview:self.imageOutputView];
    
    AVCaptureConnection *videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    videoConnection.videoMirrored = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.session startRunning];
    });
}

- (void)stopSession
{
    if (!self.session.running) {
        return;
    }
    
    if(self.isSessionBegin){
        self.isSessionBegin = NO;
        [self.session stopRunning];
        if(nil != self.deviceInput) {
            [self.session removeInput:self.deviceInput];
        }
        if(nil != self.videoOutput) {
            [self.session removeOutput:self.videoOutput];
        }
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    [self faceProcesss:image];
    //NSLog(@"didOutputSampleBuffer current thread %@, image is %@", [NSThread currentThread], image);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageOutputView.image = image;
    });
}

- (void)faceProcesss:(UIImage *)image
{
    if (self.hasFinished) {
        return;
    }
    
    CGFloat scaleValue = 0.7;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGRect detectRect = CGRectMake(screenWidth*(1-scaleValue)/2.0, screenHeight*(1-scaleValue)/2.0, screenWidth*scaleValue, screenHeight*scaleValue);
    
    CGRect circleRect = CGRectMake(62.5, 167.0, 250.0, 250.0);
    CGRect previewRect = CGRectMake(circleRect.origin.x - circleRect.size.width*(1/scaleValue-1)/2.0, circleRect.origin.y - circleRect.size.height*(1/scaleValue-1)/2.0 - 60, circleRect.size.width/scaleValue, circleRect.size.height/scaleValue);
    
    __weak typeof(self) weakSelf = self;
    [[IDLFaceLivenessManager sharedInstance] livenessStratrgyWithImage:image previewRect:previewRect detectRect:detectRect completionHandler:^(NSDictionary *images, LivenessRemindCode remindCode) {
        NSLog(@"remindCode is %@", @(remindCode));
        
        switch (remindCode) {
            case LivenessRemindCodeOK:
            {
                weakSelf.hasFinished = YES;
                [weakSelf showToast:@"认证成功"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
                break;
            case LivenessRemindCodePitchOutofDownRange:
            {
                [weakSelf showToast:@"建议略微抬头"];
            }
                break;
            case LivenessRemindCodePitchOutofUpRange:
            {
                [weakSelf showToast:@"建议略微低头"];
            }
                break;
            case LivenessRemindCodeYawOutofLeftRange:
            {
                [weakSelf showToast:@"建议略微向右转头"];
            }
                break;
            case LivenessRemindCodeYawOutofRightRange:
            {
                [weakSelf showToast:@"建议略微向左转头"];
            }
                break;
            case LivenessRemindCodePoorIllumination:
            {
                [weakSelf showToast:@"光线再亮些"];
            }
                break;
            case LivenessRemindCodeNoFaceDetected:
            {
                [weakSelf showToast:@"把脸移入框内"];
            }
                break;
            case LivenessRemindCodeImageBlured:
            {
                [weakSelf showToast:@"请保持不动"];
            }
                break;
            case LivenessRemindCodeOcclusionLeftEye:
            {
                [weakSelf showToast:@"左眼有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionRightEye:
            {
                [weakSelf showToast:@"右眼有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionNose:
            {
                [weakSelf showToast:@"鼻子有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionMouth:
            {
                [weakSelf showToast:@"嘴巴有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionLeftContour:
            {
                [weakSelf showToast:@"左脸颊有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionRightContour:
            {
                [weakSelf showToast:@"右脸颊有遮挡"];
            }
                break;
            case LivenessRemindCodeOcclusionChinCoutour:
            {
                [weakSelf showToast:@"下颚有遮挡"];
            }
                break;
            case LivenessRemindCodeTooClose:
            {
                [weakSelf showToast:@"手机拿远一点"];
            }
                break;
            case LivenessRemindCodeTooFar:
            {
                [weakSelf showToast:@"手机拿近一点"];
            }
                break;
            case LivenessRemindCodeBeyondPreviewFrame:
            {
                [weakSelf showToast:@"把脸移入框内"];
            }
                break;
            case LivenessRemindCodeLiveEye:
            {
                [weakSelf showToast:@"眨眨眼"];
            }
                break;
            case LivenessRemindCodeLiveMouth:
            {
                [weakSelf showToast:@"张张嘴"];
            }
                break;
            case LivenessRemindCodeLiveYawRight:
            {
                [weakSelf showToast:@"向右缓慢转头"];
            }
                break;
            case LivenessRemindCodeLiveYawLeft:
            {
                [weakSelf showToast:@"向左缓慢转头"];
            }
                break;
            case LivenessRemindCodeLivePitchUp:
            {
                [weakSelf showToast:@"缓慢抬头"];
            }
                break;
            case LivenessRemindCodeLivePitchDown:
            {
                [weakSelf showToast:@"缓慢低头"];
            }
                break;
            case LivenessRemindCodeLiveYaw:
            {
                [weakSelf showToast:@"摇摇头"];
            }
                break;
            case LivenessRemindCodeSingleLivenessFinished:
            {
                [weakSelf showToast:@"非常好"];
            }
                break;
            case LivenessRemindCodeVerifyInitError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyDecryptError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyInfoFormatError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyExpired:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyMissRequiredInfo:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyInfoCheckError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyLocalFileError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeVerifyRemoteDataError:
                [weakSelf showToast:@"验证失败"];
                break;
            case LivenessRemindCodeTimeout:
                [weakSelf showToast:@"验证超时"];
                break;
            case LivenessRemindCodeConditionMeet:
                NSLog(@"remindCode is LivenessRemindCodeConditionMeet");
                break;
            default:
                NSLog(@"remindCode is %@ in default", @(remindCode));
                break;
        }
    }];
}

- (void)showToast:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"message is %@", message);
        [self zb_showWithMessage:message];
    });
}

- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    @autoreleasepool {
        // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // 锁定pixel buffer的基地址
        CVPixelBufferLockBaseAddress(imageBuffer, 0);

        // 得到pixel buffer的基地址
        void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);

        // 得到pixel buffer的行字节数
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        // 得到pixel buffer的宽和高
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);

        // 创建一个依赖于设备的RGB颜色空间
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

        // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
        CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                     bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        // 根据这个位图context中的像素数据创建一个Quartz image对象
        CGImageRef quartzImage = CGBitmapContextCreateImage(context);
        // 解锁pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer,0);

        // 释放context和颜色空间
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);

        // 用Quartz image创建一个UIImage对象image
        UIImage *image = [UIImage imageWithCGImage:quartzImage];

        // 释放Quartz image对象
        CGImageRelease(quartzImage);
        return (image);
    }
}

- (AVCaptureDevice *)frontFacingCameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices) {
        if (device.position == AVCaptureDevicePositionFront) {
            captureDevice = device;
            break;
        }
    }
    
    // 如果找不到，给以提示框
    if (!captureDevice) {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}

- (void)setHasFinished:(BOOL)hasFinished
{
    _hasFinished = hasFinished;
    if (hasFinished) {
        [self stopSession];
    }
}

- (UIImageView *)imageOutputView
{
    if (_imageOutputView == nil) {
        _imageOutputView = [[UIImageView alloc] init];
        _imageOutputView.backgroundColor = [UIColor orangeColor];
    }
    return _imageOutputView;
}

//视频输出
- (AVCaptureVideoDataOutput *)videoOutput
{
    if (_videoOutput == nil) {
        _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
        [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
        NSDictionary* setcapSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey,
                                        nil];
        _videoOutput.videoSettings = setcapSettings;
    }
    return _videoOutput;
}

- (dispatch_queue_t)captureQueue
{
    if (_captureQueue == nil) {
        _captureQueue = dispatch_queue_create("com.capture", DISPATCH_QUEUE_SERIAL);
    }
    return _captureQueue;
}

- (AVCaptureConnection *)videoConnection
{
    if (_videoConnection == nil) {
        _videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
        //_videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
        _videoConnection.videoMirrored = YES;
    }
    return _videoConnection;
}

- (CIDetector *)faceDetector
{
    if (_faceDetector == nil) {
        CIContext *context = [CIContext contextWithOptions:nil];
        NSDictionary *param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
        _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    }
    return _faceDetector;
}

@end
