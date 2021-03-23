//
//  MMCFuncPublic.h
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMCFuncPublic : NSObject

+(MMCFuncPublic *)SharedFuncPublic;

/*
 * 保存default信息
 * str:需要保存的文字
 * key:关键字
 */
+(void)SaveDefaultInfo:(id)str andKey:(NSString *)key;
/*
 * 获得保存的default信息
 * key:关键字
 */
+(id)GetDefaultInfo:(NSString *)key;

@end
