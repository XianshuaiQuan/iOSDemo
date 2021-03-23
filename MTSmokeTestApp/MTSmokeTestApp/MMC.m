//
//  MMC.m
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/21.
//

#import "MMC.h"


@implementation MMC

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"title"   :@"data.title",
        @"subTitle":@"data.subtitle",
        @"data":@"data"
    };
}

@end
