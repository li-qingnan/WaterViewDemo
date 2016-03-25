//
//  Interface.h
//  WaterViewDemo
//
//  Created by Yinan on 15/5/26.
//  Copyright (c) 2015年 Z&B. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceResponder.h"
@interface Interface : NSObject
+ (instancetype)sharedInterface;

// 获取图片数据
+ (void)getPicWithCategory_name:(NSString *)category_name condition:(NSString *)condition device:(NSString *)device page:(NSString *)page per_page:(NSString *)per_page status:(NSString *)status tag_name:(NSString *)tag_name result:(void(^)(GetPicInterfaceResponder *registCodeResponder,NSError *httpError))result;

@end
