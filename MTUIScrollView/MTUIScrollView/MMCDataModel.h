//
//  MMCDataModel.h
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCDataModel : NSObject

@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *titleArray;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndTitle;

+ (id)dataModelWithImage;
+ (id)dataModelWithImageAndTitle;

@end

NS_ASSUME_NONNULL_END
