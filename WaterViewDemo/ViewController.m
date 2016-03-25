//
//  ViewController.m
//  WaterViewDemo
//
//  Created by zhangbin on 14-8-17.
//  Copyright (c) 2014年 Z&B. All rights reserved.
//


#import "ViewController.h"
#import "YNFlowView.h"
#import "YNWaterView.h"
#import "Music.h"
#import "JSONKit.h"
#import "FirstViewController.h"
#import "Interface.h"

    NSInteger page = 1;
@interface ViewController ()<ZBWaterViewDatasource,ZBWaterViewDelegate>
{
    ZBWaterView *_waterView;
}

@property (nonatomic,strong) NSMutableArray *musicArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"瀑布流";
    
    _waterView = [[ZBWaterView alloc]  initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _waterView.waterDataSource = self;
    _waterView.waterDelegate = self;
    _waterView.isDataEnd = NO;
    [self.view addSubview:_waterView];
    
    self.musicArr = [[NSMutableArray alloc] init];
    [self requestSourceData];
//    [self requestPic];
}

- (void)requestPic
{
    NSString *category_name = @"music";
    NSString *condition = @"hot";
    NSString *device = @"ios";
    NSString *page = @"1";
    NSString *per_page = @"20";
    NSString *status = @"0";
    NSString *tag_name = @"欧美|日韩";
    
    [Interface getPicWithCategory_name:category_name condition:condition device:device page:page per_page:per_page status:status tag_name:tag_name result:^(GetPicInterfaceResponder *registCodeResponder, NSError *httpError) {
        NSLog(@"+++++++ Responder= %@ %@ %@",registCodeResponder.count,registCodeResponder.ret,registCodeResponder.maxPageId);
        NSLog(@"+++++++ httpError= %@",httpError);
        self.musicArr = registCodeResponder.listArr;
//        for (Music *music in registCodeResponder.listArr) {
//            NSLog(@"+++++++ = %@",music);
//        }
    }];
}

- (void)requestSourceData
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block ViewController *VC = self;
    dispatch_async(queue, ^{
        
        NSString *category_name = @"music";
        NSString *condition = @"hot";
        NSString *device = @"ios";
        NSString *page = @"1";
        NSString *per_page = @"20";
        NSString *status = @"0";
        NSString *tag_name = @"欧美|日韩";
        
        
        NSString *str = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=%@&condition=%@&device=%@&page=%@&per_page=%@&status=%@&tag_name=%@",category_name,condition,device,page,per_page,status,tag_name];
//        NSLog(@"******* = %@",str);
        // encoding转换
        NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"******* = %@",urlStr);

        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];

        
        if (data == nil) {
            
            return ;
        }
        
        NSDictionary *sourceDic = [data objectFromJSONData];
        NSArray *sourceArr = [sourceDic objectForKey:@"list"];
        
        for (NSDictionary *dic in sourceArr) {
            
            Music *music = [[Music alloc] init];
            [music setValuesForKeysWithDictionary:dic];
            [VC.musicArr addObject:music];
        }
        //NSLog(@"musicArr = %@",self.musicArr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_waterView reloadData];
            
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZBWaterViewDatasource

// waterView 数量
- (NSInteger)numberOfFlowViewInWaterView:(ZBWaterView *)waterView
{
    return [self.musicArr count];
}
// 设置 waterView 参数
- (CustomWaterInfo *)infoOfWaterView:(ZBWaterView*)waterView
{
    
    CustomWaterInfo *info = [[CustomWaterInfo alloc] init];
    info.topMargin = 0;  //瀑布视图距离顶部
    info.leftMargin = 10;//左边距
    info.bottomMargin = 0;//瀑布试图距离底部
    info.rightMargin = 10;//右边距
    info.horizonPadding = 5;//水平间隔
    info.veticalPadding = 5;//垂直间隔
    info.numOfColumn = 2;//列数
    return info;
}
// 显示view
- (YNFlowView *)waterView:(ZBWaterView *)waterView flowViewAtIndex:(NSInteger)index
{
    Music *music = [self.musicArr objectAtIndex:index];
    
    YNFlowView *flowView = [waterView dequeueReusableCellWithIdentifier:@"cell"];
    if (flowView == nil) {
        flowView = [[YNFlowView alloc] initWithFrame:CGRectZero];
        flowView.reuseIdentifier = @"cell";
    }
    flowView.index = index;// 记录位置
    flowView.music = music;
    
    return flowView;
}

- (CGFloat)waterView:(ZBWaterView *)waterView heightOfFlowViewAtIndex:(NSInteger)index
{
    // 这里需要服务器返回图片高度
    return arc4random()%(300-200+1)+200;
}


#pragma mark - ZBWaterViewDelegate

// 加载更多
- (void)needLoadMoreByWaterView:(ZBWaterView *)waterView;
{
  
    __block ViewController *vc = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2.0];
        
        NSString *str = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=music&condition=hot&device=ios&page=%ld&per_page=20&status=0&tag_name=欧美|日韩",page];
        
        // encoding转换
        NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        
        if (data == nil) {
            
            return ;
        }
        
        NSDictionary *sourceDic = [data objectFromJSONData];
        NSArray *sourceArr = [sourceDic objectForKey:@"list"];
        
        //NSLog(@"%@",sourceArr);
        
        for (NSDictionary *dic in sourceArr) {
            
            Music *music = [[Music alloc] init];
            [music setValuesForKeysWithDictionary:dic];
            [vc.musicArr addObject:music];
        }
        //NSLog(@"musicArr = %@",self.musicArr);


        dispatch_async(dispatch_get_main_queue(), ^{
            [_waterView endLoadMore];
            [_waterView reloadData];
        });
    });
    
    page++;
}

// 滚动回调
- (void)phoneWaterViewDidScroll:(ZBWaterView *)waterView
{
    //do what you want to do
    return;
}

// 监测选中
- (void)waterView:(ZBWaterView *)waterView didSelectAtIndex:(NSInteger)index
{
    Music *music = [self.musicArr objectAtIndex:index];
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.music = music;
    [self.navigationController pushViewController:firstVC animated:YES];
    
    NSLog(@"didSelectAtIndex%ld",index);
}

@end
