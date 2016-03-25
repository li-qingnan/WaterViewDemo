//
//  FirstViewController.m
//  WaterViewDemo
//
//  Created by 李一楠 on 14/11/29.
//  Copyright (c) 2014年 Z&B. All rights reserved.
//

#import "FirstViewController.h"
#import "JingRoundView.h"
#import "UIImageView+WebCache.h"
#import "Music.h"

@interface FirstViewController ()<JingRoundViewDelegate>

@property (nonatomic,strong) JingRoundView *roundView;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = self.music.title;
    [self createRoundView];
}

- (void)createRoundView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.roundView = [[JingRoundView alloc] initWithFrame:CGRectMake(10, 150, 300, 300)];
    [self.view addSubview:self.roundView];
    
    self.roundView.delegate = self;
    self.roundView.roundImage = [UIImage imageNamed:@"lv"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.music.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"lv.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cacheType = SDImageCacheTypeDisk;
        
        self.roundView.roundImage = image;
    }];

    self.roundView.rotationDuration = 8.0;
    self.roundView.isPlay = YES;// 是否转圈
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playStatuUpdate:(BOOL)playState
{
    //NSLog(@"%@...", playState ? @"播放": @"暂停了");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
