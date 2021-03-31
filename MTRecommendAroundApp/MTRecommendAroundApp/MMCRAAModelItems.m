//
//  MMCRAAModelItems.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import "MMCRAAModelItems.h"

@interface MMCRAAModelItems()

@property (nonatomic ,strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subTitle2;
@property (nonatomic, strong) NSString *topRightInfo;
@property (nonatomic, strong) NSString *mainMessage;

@end

@implementation MMCRAAModelItems

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"imageUrl" : @"imageUrl" ,
               @"title" : @"title" ,
            @"subTitle" : @"subTitle" ,
           @"subTitle2" : @"subTitle2" ,
        @"topRightInfo" : @"topRightInfo" ,
         @"mainMessage" : @"mainMessage" ,
    };
};

@end
