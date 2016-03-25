//
//  YNFlowView.h
//
//
//  Created by Yinan on 15-4-24.
//  Copyright (c) 2015年 Yinan. All rights reserved.
//


#import <UIKit/UIKit.h>
@class YNFlowView;
@class Music;

@protocol YNFlowViewDelegate <NSObject>

- (void)pressedAtFlowView:(YNFlowView *)flowView;

@end

@interface YNFlowView : UIView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, assign) id <YNFlowViewDelegate> flowViewDelegate;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) Music *music;

@end
