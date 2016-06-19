//
//  newPhoneView.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol newPhoneViewDelegate <NSObject>
-(void)listening;
@end
@interface newPhoneView : UIView

@property (nonatomic ,strong)UILabel* localIPLabel;
@property(nonatomic,assign)id <newPhoneViewDelegate>delegate;

@end
