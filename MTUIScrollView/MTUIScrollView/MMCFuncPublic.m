//
//  MMCFuncPublic.m
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/16.
//

#import "MMCFuncPublic.h"

MMCFuncPublic *_funcPublic = nil;

@implementation MMCFuncPublic

+(MMCFuncPublic *)SharedFuncPublic{
    if (_funcPublic == nil) {
        _funcPublic = [[MMCFuncPublic alloc] init];
    }
    return _funcPublic;
}

/*
 * 保存default信息
 * str:需要保存的文字
 * key:关键字
 */
+(void)SaveDefaultInfo:(id)str andKey:(NSString *)key{
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    [MMCFuncPublic ExplainInfoByClass:str];
    [standardUserDefault setValue:str forKey:key];
    
    [standardUserDefault synchronize];
}
/*
 * 通过各种类型将null变成字符串
 */
+(void)ExplainInfoByClass:(id)sender{
    if ([sender isKindOfClass:[NSDictionary class]]) {
        NSArray *tempArray = [sender allKeys];
        for (NSString *key in tempArray) {
            if ([sender objectForKey:key] == [NSNull null]) {
                [sender setObject:@"" forKey:key];
            }else if ([[sender objectForKey:key] isKindOfClass:[NSDictionary class]])
            {
                [MMCFuncPublic ExplainInfoByClass:[sender objectForKey:key]];
            }
        }
    }else if ([sender isKindOfClass:[NSArray class]])
    {
        for (NSInteger i=0; i < [sender count]; i++) {
            NSDictionary *dict = [sender objectAtIndex:i];
            [MMCFuncPublic ExplainInfoByClass:dict];
        }
    }else if ([sender isKindOfClass:[NSNull class]])
    {
        [sender setObject:@"" forKey:sender];
    }
}
/*
 * 获得保存的default信息
 * key:关键字
 */
+(id)GetDefaultInfo:(NSString *)key{
    id temp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (temp == nil) {
        return nil;
    }
    return temp;
}

@end
