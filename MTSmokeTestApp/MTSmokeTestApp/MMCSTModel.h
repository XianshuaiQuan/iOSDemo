//
//  MMCSTModel.h
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/20.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCSTModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray<NSDictionary *> *pois;

@end

NS_ASSUME_NONNULL_END
