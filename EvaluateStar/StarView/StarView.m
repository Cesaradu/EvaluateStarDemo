//
//  StarView.m
//
//  Created by cesar on 16/11/25.
//  Copyright © 2016年 hztuen. All rights reserved.
//

#import "StarView.h"
#import "UIView+Extension.h"
#import "Masonry.h"
#import "SDiPhoneVersion.h"

#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height)

// 屏幕适配比例

#define Suit55Inch           1.104
#define Suit4Inch            1.171875

// 系统判定
#define IOS_VERSION    [[[UIDevice currentDevice]systemVersion]floatValue]
#define IS_IOS8        (IOS_VERSION>=8.0)
#define IS_IOS7        (IOS_VERSION>=7.0)
#define Is_IOS9        (IOS_VERSION>=9.0 && IOS_VERSION<10)

// 屏幕判定
#define IS_IPHONE35INCH  ([SDiPhoneVersion deviceSize] == iPhone35inch ? YES : NO)//4, 4S
#define IS_IPHONE4INCH  ([SDiPhoneVersion deviceSize] == iPhone4inch ? YES : NO)//5, 5C, 5S, SE
#define IS_IPHONE47INCH  ([SDiPhoneVersion deviceSize] == iPhone47inch ? YES : NO)//6, 6S, 7
#define IS_IPHONE55INCH ([SDiPhoneVersion deviceSize] == iPhone55inch ? YES : NO)//6P, 6SP, 7P

#define StarCount       5

@interface StarView ()

@property (nonatomic, strong) NSMutableArray *starArray;
@property (nonatomic, assign) int starCount;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation StarView
{
    BOOL isAddStar;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInit];
        [self buildUI];
    }
    return self;
}

- (void)setupInit {
    self.backgroundColor = [UIColor whiteColor];
    self.starArray = [NSMutableArray array];
}

-(void)buildUI {
    //点击评星label
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击/滑动评星";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset([self Suit:15]);
        make.height.mas_equalTo([self Suit:16]);
    }];
    
    //line1
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(self.mas_left).offset([self Suit:15]);
        make.right.equalTo(label.mas_left).offset([self Suit:-15]);
        make.height.mas_equalTo([self Suit:0.5]);
    }];
    
    //line2
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(label.mas_right).offset([self Suit:15]);
        make.right.equalTo(self.mas_right).offset([self Suit:-15]);
        make.height.mas_equalTo([self Suit:0.5]);
    }];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.distribution = UIStackViewDistributionEqualCentering;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset([self Suit:8]);
        make.width.mas_equalTo(self.width);
    }];
    
    for (int i = 0; i < StarCount; i++) {
        UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_unselected"]];
        star.contentMode = UIViewContentModeScaleAspectFill;
        [self.stackView addArrangedSubview:star];
        [self.starArray addObject:star];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIImageView *firstStar = self.starArray[0];
    UIImageView *lastStar = self.starArray[StarCount-1];
    if((point.x > firstStar.x && point.x < (lastStar.x + lastStar.width))&&(point.y > firstStar.y && point.y< self.height)) {
        isAddStar = YES;
    } else {
        isAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(isAddStar) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    
    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(isAddStar) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    isAddStar = NO;
    return;
}

-(void)setStarForegroundViewWithPoint:(CGPoint)point{
    
    self.score = 0;
    for (int i = 0; i < StarCount; i++) {
        self.score = self.score + [self changeImg:point.x image:self.starArray[i]];
    }
    
    //评论最少半星
    if(self.score == 0) {
        self.score = 0.5;
        [self.starArray[0] setImage:[UIImage imageNamed:@"star_half"]];
    }
    
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.score);
    }
}

-(CGFloat)changeImg:(float)x image:(UIImageView*)img
{
    if(x > img.x + img.width/2) {
        [img setImage:[UIImage imageNamed:@"star_selected"]];
        return 1;
    } else if(x > img.x) {
        [img setImage:[UIImage imageNamed:@"star_half"]];
        return 0.5;
    } else {
        [img setImage:[UIImage imageNamed:@"star_unselected"]];
        return 0;
    }
}


- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
