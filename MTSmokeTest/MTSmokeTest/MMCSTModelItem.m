//
//  MMCSmokeTestModel.m
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/20.
//

#import "MMCSTModelItem.h"
#import <UIKit/UIKit.h>

@interface MMCSTModelItem()

@end

@implementation MMCSTModelItem
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                @"channel" : @"channel",
                @"city"    : @"city",
            @"channelName" : @"channelname",
                  @"poiid" : @"poiid",
                   @"name" : @"adress",
                   @"lat"  : @"lat",
                    @"lng" : @"lng",
               @"frontImg" : @"frontImg",
                 @"adress" : @"adress"
            };
}


@end
