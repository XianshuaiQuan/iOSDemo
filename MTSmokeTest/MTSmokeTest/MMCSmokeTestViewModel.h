//
//  MMCSmokeTestViewModel.h
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


NS_ASSUME_NONNULL_BEGIN

@interface MMCSmokeTestViewModel : NSObject

@property (nonatomic, strong) RACCommand *dataRequest;

@end

NS_ASSUME_NONNULL_END
