//
//  Interface.m
//  WaterViewDemo
//
//  Created by Yinan on 15/5/26.
//  Copyright (c) 2015年 Z&B. All rights reserved.
//

#import "Interface.h"
#import "Header.h"

#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@interface Interface ()

@property(nonatomic, strong) NSString *baseURLString;

@end

@implementation Interface

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseURLString = kBaseUrl;
    }
    return self;
}

+ (instancetype)sharedInterface
{
    static Interface *interface;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        interface = [[Interface alloc]init];
    });
    return interface;
}

+ (AFHTTPRequestOperationManager *)sharedHTTPOperationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", /*@"text/html", */ @"text/json", /*@"text/javascript",*/ nil];
    return manager;
}

+ (void)getPicWithCategory_name:(NSString *)category_name condition:(NSString *)condition device:(NSString *)device page:(NSString *)page per_page:(NSString *)per_page status:(NSString *)status tag_name:(NSString *)tag_name result:(void(^)(GetPicInterfaceResponder *registCodeResponder,NSError *httpError))result
{
    AFHTTPRequestOperationManager *manager = [Interface sharedHTTPOperationManager];
    NSString *getPicUrlStr =[NSString stringWithFormat:@"%@/m/explore_album_list",[Interface sharedInterface].baseURLString];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:category_name, @"category_name",condition,@"condition",device,@"device",page,@"page",per_page,@"per_page",status,@"status",tag_name,@"tag_name", nil];
 
    [manager GET:getPicUrlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetPicInterfaceResponder *getPicResponder = [[GetPicInterfaceResponder alloc] initWithJSONObject:responseObject];
        result(getPicResponder,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        result(nil,error);
    }];
}

@end
