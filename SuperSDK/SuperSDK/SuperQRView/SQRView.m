//
//  SDKQRView.m
//  NewProject
//
//  Created by 刘超 on 14/12/8.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "SQRView.h"
@interface SQRView()<UIAlertViewDelegate>
@property (nonatomic, copy) SQRCallBack qrCallBack;

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@end
@implementation SQRView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCamera];
    }
    return self;
}
- (void)setCallBack:(SQRCallBack)callBack {
    self.qrCallBack = callBack;
}
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size {
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *image = [filter valueForKey:@"outputImage"];
    
    // Calculate the size of the generated image and the scale for the desired image size
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));
    
    // Since CoreImage nicely interpolates, we need to create a bitmap image that we'll draw into
    // a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
#if TARGET_OS_IPHONE
    CIContext *context = [CIContext contextWithOptions:nil];
#else
    CIContext *context = [CIContext contextWithCGContext:bitmapRef options:nil];
#endif
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage* qrImage = [UIImage imageWithCGImage:scaledImage];
    
    return qrImage;
}
- (void)setupCamera {
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"APP要使用您的相机功能";
        alert.message = @"请您在\"设置-->隐私-->相机\"\n 允许APP访问您的相机\n 您才能使用二维码扫描功能";
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        return;
    }

    // Session
    _session = [[AVCaptureSession alloc]init];
    
    
    
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }

    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }

    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];

    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.bounds;
    [self.layer insertSublayer:self.preview atIndex:0];

    // Start
    
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SQRCallBack block = self.qrCallBack;
    if (block) {
        block(nil, self, NO);
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if ([metadataObjects count] >0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    SQRCallBack block = self.qrCallBack;
    if (block) {
        block(stringValue, self, YES);
    }
}
- (void)start {
    [_session startRunning];
}
- (void)stop {
    [_session stopRunning];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _preview.frame = self.bounds;
}


@end
