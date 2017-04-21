//
//  StarView.h
//
//  Created by cesar on 16/11/25.
//  Copyright © 2016年 hztuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

@property (nonatomic, copy) void (^valueChangeBlock)(CGFloat value);


@end
