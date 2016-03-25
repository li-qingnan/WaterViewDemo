//
//  Music.m
//  WaterViewDemo
//
//  Created by 李一楠 on 14/11/29.
//  Copyright (c) 2014年 Z&B. All rights reserved.
//

#import "Music.h"

@implementation Music

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (instancetype)initWithPicDic:(NSDictionary *)picDic
{
    self = [super init];
    if(self){
        if(picDic){
            self.title = [picDic objectForKey:@"title"];
            self.albumCoverUrl290 = [picDic objectForKey:@"albumCoverUrl290"];
        }
    }
    
    return self;
}

@end
