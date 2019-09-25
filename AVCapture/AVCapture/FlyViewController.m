//
//  FlyViewController.m
//  AVCapture
//
//  Created by muyu on 2019/9/5.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "FlyViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MCCategory/UIView+MCFrame.h>
#import "UIViewController+KKAuthorization.h"

@interface FlyViewController ()
<
AVCaptureMetadataOutputObjectsDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate
>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) UIImageView *imageOutputView;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) dispatch_queue_t captureQueue;
@property (nonatomic, strong) CIDetector *faceDetector;

@end

@implementation FlyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self kk_checkCameraAvailability:^(BOOL auth) {
        if (auth) {
            [self startCapture2];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self captureNow];
}

- (void)startCapture
{
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    if ([self.session canAddInput:input])
    {
        [self.session addInput:input];
    }
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGFloat width = self.view.width/2;
    self.preview.frame = CGRectMake(width/2, 100, width, width);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.session startRunning];
    
    self.imageOutputView.frame = CGRectMake(width/2, 120+width, width, width);
    [self.view addSubview:self.imageOutputView];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImageOutput];
    
    // 设置前置摄像头拍照不镜像
    AVCaptureDevicePosition currentPosition = [[input device] position];
    AVCaptureConnection *connection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (currentPosition == AVCaptureDevicePositionUnspecified || currentPosition == AVCaptureDevicePositionFront) {
        connection.videoMirrored = YES;
    } else {
        connection.videoMirrored = NO;
    }
}

- (void)startCapture2
{
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:self.videoOutput]) {
        [self.session addOutput:self.videoOutput];
    }
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGFloat width = self.view.width/2;
    self.preview.frame = CGRectMake(width/2, 100, width, width);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    self.imageOutputView.frame = CGRectMake(width/2, 120+width, width, width);
    [self.view addSubview:self.imageOutputView];
    
    AVCaptureConnection *videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    videoConnection.videoMirrored = YES;
    
    [self.session startRunning];
}

// 获取前置/后置 摄像头
// AVCaptureDeviceDiscoverySession

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //    if (metadataObjects.count>0) {
    //        //[self.session stopRunning];
    //        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
    //        if (metadataObject.type == AVMetadataObjectTypeFace) { // 照片也能识别
    //            AVMetadataObject *objec = [self.preview transformedMetadataObjectForMetadataObject:metadataObject];
    //            NSLog(@"%@",objec);
    //
    //            //AVMetadataFaceObject
    //        }
    //    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    //NSLog(@"didOutputSampleBuffer current thread %@, image is %@", [NSThread currentThread], image);
    
    CIImage *ci_image = [CIImage imageWithCGImage:image.CGImage];
    NSDictionary *options = @{
                              CIDetectorEyeBlink : @YES
                              };
    NSArray<CIFeature *> *features = [self.faceDetector featuresInImage:ci_image options:options];
    for (CIFeature *feature in features) {
        if ([feature isKindOfClass:[CIFaceFeature class]]) {
            CIFaceFeature *faceFeature = (CIFaceFeature *)feature;
            NSLog(@"hasSmile %@, leftEyeClosed %@, rightEyeClosed %@", @(faceFeature.hasSmile), @(faceFeature.leftEyeClosed), @(faceFeature.rightEyeClosed));
        } else {
            NSLog(@"no face feature feature is %@", [feature class]);
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageOutputView.image = image;
    });
}

- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
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

- (UIImage *)convertSampleBufferToUIImageSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the plane pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    
    // Get the number of bytes per row for the plane pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer,0);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent gray color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGImageAlphaNone);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    
    return (image);
    
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

- (void)setupCaptureSession
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [self.view.layer addSublayer:captureVideoPreviewLayer];
    
    NSError *error = nil;
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // Handle the error appropriately.
        NSLog(@"ERROR: trying to open camera: %@", error);
    }
    [session addInput:input];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:self.stillImageOutput];
    
    [session startRunning];
}

- (void)captureNow
{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    NSLog(@"about to request a capture from: %@", self.stillImageOutput);
    __weak typeof(self) weakSelf = self;
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        NSLog(@"current thread %@", [NSThread currentThread]);
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        weakSelf.imageOutputView.image = image;
    }];
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

- (NSString *)title
{
    return @"科大讯飞";
}

@end
