//
//  MMC.h
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/21.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMC : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
