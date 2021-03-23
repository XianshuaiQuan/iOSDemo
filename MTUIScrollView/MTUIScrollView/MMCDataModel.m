//
//  MMCDataModel.m
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/16.
//

#import "MMCDataModel.h"

#define PATH [[NSBundle mainBundle] pathForResource:@"scrollView.plist" ofType:nil]

@implementation MMCDataModel
- (instancetype)initWithImageName {
    if ([super init]) {
        self.imageArray = [NSArray arrayWithContentsOfFile:PATH][0];
    }
    return self;
}

- (instancetype)initWithImageNameAndTitle {
    if ([super init]) {
        self.imageArray = [NSArray arrayWithContentsOfFile:PATH][0];
        self.titleArray = [NSArray arrayWithContentsOfFile:PATH][1];
    }
    return self;
}

+ (id)dataModelWithImage {
    return [[self alloc]initWithImageName];
}

+ (id)dataModelWithImageAndTitle {
    return [[self alloc]initWithImageNameAndTitle];
}


@end
