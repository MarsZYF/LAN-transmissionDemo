//
//  Header.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define WeakSelf __weak __typeof(&*self)weakSelf =self
#define SOCKETPORT  5555
//单例类创建
// .h
#define single_interface(class)  + (class *)shared##class;
// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}
//系统版本相关
#define ISIOS5 ([UIDevice currentDevice]  sytemVersion]  floatValue]>=5.0)
#define ISIOS6 ([UIDevice currentDevice]  sytemVersion]  floatValue]>=6.0)
#define ISIOS7 ([UIDevice currentDevice]  sytemVersion]  floatValue]>=7.0)
#define ISIOS8 ([UIDevice currentDevice]  sytemVersion]  floatValue]>=8.0)
#define ISIOS9 ([UIDevice currentDevice]  sytemVersion]  floatValue]>=9.0)
//bonjour 配置相关
static NSString * const KBonjourType = @"_bonjour._tcp.";
static NSString * const KDomainString = @"local.";
static NSString * const KBrowserDomainString = @"local";
////NSLog输出只在Debug下输出,Release下不输出
//#ifdef __OPTIMIZE__
//#define NSLog(...)NSLog(__VA_ARGS__)
//#else
//#define NSLog(...){}
//#endif

#endif /* Header_h */
