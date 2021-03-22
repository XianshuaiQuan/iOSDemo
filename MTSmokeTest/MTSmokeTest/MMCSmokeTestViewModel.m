//
//  MMCSmokeTestViewModel.m
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/19.
//

#import "MMCSmokeTestViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>
#import "MMCSTModel.h"
#import "MMC.h"

@interface MMCSmokeTestViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *serviceManager;

@end

@implementation MMCSmokeTestViewModel

#pragma mark - lazy
- (RACCommand *)dataRequest {
    if (!_dataRequest) {
        @weakify(self)
        _dataRequest = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[self dataRequestSignal:input] takeUntil:self.rac_willDeallocSignal];
        }];
    }
    return _dataRequest;
}

- (AFHTTPSessionManager *)serviceManager {
    if (!_serviceManager) {
        _serviceManager  = [AFHTTPSessionManager manager];
    }
    return _serviceManager;
}

#pragma mark -signal
- (RACSignal *)dataRequestSignal:(id)input {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSString *url = @"https://apimobile.meituan.com/group/v1/recommend/unity/recommends?uuid=0000000000000E689DD57B4FA43CA987654B4A61C929CA159695075091439900&utm_source=Alpha&poi_id=192623449&position=39.943268%2C116.184503&utm_content=0000000000000E689DD57B4FA43CA987654B4A61C929CA159695075091439900&utm_term=11.7.200&utm_medium=iphone&scene=lbs_map_nearby&version_name=11.7.200&tab=FOOD&utm_campaign=AgroupBgroupGhomepage_category3_20__a1__c__e126313H0&__reqTraceID=2F5AA3CF-4C01-44CF-ABD9-CA6032BBB6EF&language=zh-CN&ci=1&client=iphone&msid=B890A778-8329-4E60-B5F2-96D81504594F1613635282641902";
        
        [self.serviceManager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            //进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //成功(先将json转化为字符串，再将字符串转化为NSData)
            NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"POIList.json" ofType:nil];
            NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
            NSData *jsonData = [jsonString  dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:jsonArray forKey:@"dataSource"];
            
            [subscriber sendNext:jsonArray];
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            NSLog(@"网络请求失败");
        }];
        
        return nil;
    }];
}


- (NSDictionary *)jsonDictWithString:(NSString *)string
{
    if (string && 0 != string.length)
    {
        NSError *error;
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error)
        {
            NSLog(@"json解析失败：%@", error);
            return nil;
        }
        
        return jsonDict;
    }
    
    return nil;
}


@end
