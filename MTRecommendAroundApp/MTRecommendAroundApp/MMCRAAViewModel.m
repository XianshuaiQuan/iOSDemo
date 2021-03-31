//
//  MMCDataSourceRequest.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import "MMCRAAViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>
#import "MMCRAAModel.h"

@interface MMCRAAViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *serviceManager;

@end

@implementation MMCRAAViewModel

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

- (RACSignal *)dataRequestSignal :(id)input {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSString *url = @"https://apimobile.meituan.com/group/v1/recommend/unity/recommends?uuid=0000000000000E689DD57B4FA43CA987654B4A61C929CA159695075091439900&utm_source=Alpha&poi_id=192623449&position=39.943268%2C116.184503&utm_content=0000000000000E689DD57B4FA43CA987654B4A61C929CA159695075091439900&utm_term=11.7.200&utm_medium=iphone&scene=lbs_map_nearby&version_name=11.7.200&tab=FOOD&utm_campaign=AgroupBgroupGhomepage_category3_20__a1__c__e126313H0&__reqTraceID=2F5AA3CF-4C01-44CF-ABD9-CA6032BBB6EF&language=zh-CN&ci=1&client=iphone&msid=B890A778-8329-4E60-B5F2-96D81504594F1613635282641902";
        [self.serviceManager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"正在请求数据");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"网络请求成功。");
            MMCRAAModel *model = [MTLJSONAdapter modelOfClass:[MMCRAAModel class] fromJSONDictionary:responseObject error:nil];
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络请求失败！");
        }];
        return nil;
    }];
}

- (AFHTTPSessionManager *)serviceManager {
    if (!_serviceManager) {
        _serviceManager = [AFHTTPSessionManager manager];
    }
    return _serviceManager;
}

@end
