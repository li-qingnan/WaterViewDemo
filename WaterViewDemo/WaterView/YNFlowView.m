//
//  YNFlowView.m
//  
//
//  Created by Yinan on 15-4-24.
//  Copyright (c) 2015年 Yinan. All rights reserved.
//

#import "YNFlowView.h"
#import "UIImageView+WebCache.h"
#import "Music.h"

@interface YNFlowView()
{
    
}
@end

@implementation YNFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews
{
    self.imageView = [[UIImageView alloc] init];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.tag = self.tag;
    self.btn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.btn.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    
    [self.btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];

}


- (void)setMusic:(Music *)music
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:music.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"lv.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cacheType = SDImageCacheTypeDisk;
        self.imageView.image = image;
        [self.btn setImage:self.imageView.image forState:UIControlStateNormal];
    }];
}

- (void)pressed:(id)sender
{
    if (self) {
        if ([_flowViewDelegate respondsToSelector:@selector(pressedAtFlowView:)]) {
            [_flowViewDelegate pressedAtFlowView:self];
        }
    }
}




@end
