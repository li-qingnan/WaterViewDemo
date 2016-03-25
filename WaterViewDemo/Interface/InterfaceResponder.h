//
//  InterfaceResponder.h
//  WaterViewDemo
//
//  Created by Yinan on 15/5/26.
//  Copyright (c) 2015年 Z&B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceResponder : NSObject
/**
 *  接口响应者便利初始化，json解析
 *
 *  @param JSONObject 获取到的json数据
 *
 *  @return 响应者本身
 */
- (instancetype)initWithJSONObject:(id)JSONObject;

@property(nonatomic,strong) NSDictionary *infoDic;//接口信息字典

/*!
 *  @brief  log请求到的JSON
 */
- (void)logJSON;

@end

#pragma mark -- 获取图片
@interface GetPicInterfaceResponder:InterfaceResponder

@property (nonatomic,copy) NSString *count;
@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,copy) NSString *maxPageId;
@property (nonatomic,copy) NSString *ret;

@end
