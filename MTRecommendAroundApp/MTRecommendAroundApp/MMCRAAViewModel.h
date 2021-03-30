//
//  MMCDataSourceRequest.h
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCRAAViewModel : NSObject

@property (nonatomic, strong) RACCommand *dataRequest;

@end

NS_ASSUME_NONNULL_END
