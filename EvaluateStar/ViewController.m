//
//  ViewController.m
//  EvaluateStar
//
//  Created by hztuen on 2017/4/19.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ViewController.h"
#import "StarView.h"
#import "SDiPhoneVersion.h"
#import "ShowStarView.h"

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

@interface ViewController ()

@property (nonatomic, strong) StarView *starView; //评价
@property (nonatomic, strong) ShowStarView *showStarView; //展示
@property (nonatomic, assign) CGFloat starValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [self Suit:100], SCREEN_WIDTH, [self Suit:20])];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.text = @"0";
    [self.view addSubview:scoreLabel];
    
    //星星展示
    self.showStarView = [[ShowStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-[self Suit:35], [self Suit:125], [self Suit:70], [self Suit:20])];
    self.showStarView.backgroundColor = [UIColor redColor];
    self.showStarView.level = 0;
    [self.view addSubview:self.showStarView];
    
    //星星评价
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-[self Suit:150], [self Suit:200], [self Suit:300], [self Suit:100])];
    __weak typeof(self) weakSelf = self;
    self.starView.valueChangeBlock = ^(CGFloat value) {
        NSLog(@"score = %.1lf", value);
        scoreLabel.text = [NSString stringWithFormat:@"%.1lf", value];
        weakSelf.showStarView.level = value;
    };
    [self.view addSubview:self.starView];
    
    
}

- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
