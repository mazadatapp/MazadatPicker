//
//  MazadatPicker.m
//  MazadatPicker
//
//  Created by Karim Saad on 15/11/2022.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(MazadatPicker,NSObject)
RCT_EXTERN_METHOD(increment)

RCT_EXTERN_METHOD(openCamera:(NSString *)title_ aspect_ratio_x:(NSInteger)aspect_ratio_x aspect_ratio_y:(NSInteger)aspect_ratio_y promise:(RCTPromiseResolveBlock)promise reject:(RCTPromiseRejectBlock)reject)
 RCT_EXTERN_METHOD(openGallery:(NSString *)title_ aspect_ratio_x:(NSInteger)aspect_ratio_x aspect_ratio_y:(NSInteger)aspect_ratio_y promise:(RCTPromiseResolveBlock)promise reject:(RCTPromiseRejectBlock)reject)
 RCT_EXTERN_METHOD(editImage:(NSString *)path_ title_:(NSString *)title_ aspect_ratio_x:(NSInteger)aspect_ratio_x aspect_ratio_y:(NSInteger)aspect_ratio_y promise:(RCTPromiseResolveBlock)promise reject:(RCTPromiseRejectBlock)reject)
+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
