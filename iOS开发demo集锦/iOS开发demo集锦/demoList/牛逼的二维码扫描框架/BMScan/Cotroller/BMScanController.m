//
//  BMScanController.m
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMScanController.h"
#import <AVFoundation/AVFoundation.h>

CGRect screenBounds() {
    UIScreen *screen = [UIScreen mainScreen];
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)]
        && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGRectMake(0, 0, CGRectGetHeight(screen.bounds), CGRectGetWidth(screen.bounds));
    }
    return screen.bounds;
}

AVCaptureVideoOrientation videoOrientationFromCurrentDeviceOrientation() {
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            return AVCaptureVideoOrientationPortrait;
            break;
    }
}

@interface BMScanController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;
/**
 数据源代理（主要提供一些配置）
 */
@property (weak, nonatomic) id <BMScanDataSource> dataSource;

/**
 代理（事件回调）
 */
@property (weak, nonatomic) id <BMScanDelegate> delegate;
@end

@implementation BMScanController

#pragma mark -

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        || authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"没有相机 或者 没有相机权限");
        return ;
    }
    [self creatScanning];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self closureScanning];
}

#pragma mark - getters setters

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        // 设置代理 在主线程里刷新
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        __weak typeof(self) wself = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                          object:nil
                                                           queue:[NSOperationQueue currentQueue]
                                                      usingBlock: ^(NSNotification *_Nonnull note) {
                                                          __strong typeof(wself) self = wself;
                                                          if ([self.dataSource respondsToSelector:@selector(rectOfInterestInScanController:)]) {
                                                              self.output.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:[self.dataSource rectOfInterestInScanController:self]];
                                                          }
                                                      }];
    }
    return _output;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [AVCaptureSession new];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _previewLayer.videoGravity = AVLayerVideoGravityResize;
        // 必须添加
        _previewLayer.frame = screenBounds();
        _previewLayer.connection.videoOrientation = videoOrientationFromCurrentDeviceOrientation();
    }
    return _previewLayer;
}

#pragma mark - 系统delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count) {
        // 停止扫描
        if (metadataObjects.count) {
            [self closureScanning];
            AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
            if ([self.delegate respondsToSelector:@selector(scanController:captureWithValueString:)]) {
                [self.delegate scanController:self captureWithValueString:metadataObject.stringValue];
            }
        }
    }
}

#pragma mark - 自定义delegate

- (void)scanController:(BMScanController *)scanController captureWithValueString:(NSString *)valueString {
    [self closureScanning];
}

#pragma mark - 公有方法

- (void)startScanning {
    [self.session startRunning];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

- (void)closureScanning {
    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
}

#pragma mark - 私有方法

// 创建扫描
- (void)creatScanning {

    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    
    // 高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:self.output];
    
    // 设置扫码支持的编码格式
    self.output.metadataObjectTypes = @[
                                        AVMetadataObjectTypeUPCECode,
                                        AVMetadataObjectTypeCode39Code,
                                        AVMetadataObjectTypeCode39Mod43Code,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode93Code ,
                                        AVMetadataObjectTypeCode128Code ,
                                        AVMetadataObjectTypePDF417Code,
                                        AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeAztecCode];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

#pragma mark - 事件响应

@end
