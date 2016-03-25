//
//  Music.h
//  WaterViewDemo
//
//  Created by 李一楠 on 14/11/29.
//  Copyright (c) 2014年 Z&B. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *albumCoverUrl290;
-(instancetype)initWithPicDic:(NSDictionary *)picDic;
@end
