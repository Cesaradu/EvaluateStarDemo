# EvaluateStarDemo

效果图

![image](https://github.com/Cesaradu/EvaluateStarDemo/blob/master/star.gif)

//星星展示

self.showStarView = [[ShowStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-[self Suit:35], [self Suit:125], [self Suit:70], [self Suit:20])];

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
