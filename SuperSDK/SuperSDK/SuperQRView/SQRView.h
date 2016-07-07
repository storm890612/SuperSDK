//
//  SDKQRView.h
//  NewProject
//
//  Created by 刘超 on 14/12/8.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class SQRView;
typedef void(^SQRCallBack)(NSString *qrString, SQRView *qrView, BOOL isAuthorized);

@interface SQRView : UIView <AVCaptureMetadataOutputObjectsDelegate>
- (void)setCallBack:(SQRCallBack)callBack;
// 识别是连续的，一般在block回调的时候需要停止识别，等需要时再启动。
- (void)start;
- (void)stop;

// 生成qrImage
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size;

@end
