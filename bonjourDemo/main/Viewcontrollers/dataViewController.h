//
//  dataViewController.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/24.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (nonatomic,copy)NSString * hostIP;


@end
