//
//  MMCRAAModel.h
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCRAAModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<NSDictionary *> *data;

@end

NS_ASSUME_NONNULL_END
