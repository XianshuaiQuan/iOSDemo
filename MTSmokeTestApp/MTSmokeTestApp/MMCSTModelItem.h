//
//  MMCSmokeTestModel.h
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/20.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCSTModelItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, strong) NSString *poiid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *adress;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, strong) NSString *frontImg;

@end

NS_ASSUME_NONNULL_END
