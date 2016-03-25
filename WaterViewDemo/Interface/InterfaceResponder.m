//
//  InterfaceResponder.m
//  WaterViewDemo
//
//  Created by Yinan on 15/5/26.
//  Copyright (c) 2015年 Z&B. All rights reserved.
//

#import "InterfaceResponder.h"
#import "JSONKit.h"
#import "Music.h"

@interface InterfaceResponder()

@property(nonatomic,assign) id JSONObj;

@end

@implementation InterfaceResponder

- (instancetype)initWithJSONObject:(id)JSONObject
{
    self = [super init];
    if (self) {
        JSONDecoder *decoder = [JSONDecoder decoder];
        self.JSONObj = JSONObject;
        if (JSONObject) {
            self.infoDic = [decoder objectWithData:JSONObject];
            
        }
    }
    return self;
}

- (void)logJSON
{
    if (self.JSONObj) {
        NSLog(@"\n\n\n*****************\n\n\n请求到的数据（真实的返回数据）：%@\n\n\n*****************\n\n\n",[[NSString alloc] initWithData:self.JSONObj encoding:NSUTF8StringEncoding]);
    }
}
@end

@implementation GetPicInterfaceResponder

- (instancetype)initWithJSONObject:(id)JSONObject
{
    self = [super initWithJSONObject:JSONObject];
    if (self) {
        self.listArr = [[NSMutableArray alloc] init];
        
        if (self.infoDic) {
            self.count = [self.infoDic objectForKey:@"count"];
            self.maxPageId = [self.infoDic objectForKey:@"maxPageId"];
            NSArray *sourceArr = [self.infoDic objectForKey:@"list"];
            self.ret = [self.infoDic objectForKey:@"ret"];
            
            for (NSDictionary *dic in sourceArr) {
                
                Music *music = [[Music alloc] init];
                [music setValuesForKeysWithDictionary:dic];
                [self.listArr addObject:music];
               
                /*
                Music *music = [[Music alloc] initWithPicDic:dic];
                [self.listArr addObject:music];
                 */
            }
        }
    }
    return self;
}

@end