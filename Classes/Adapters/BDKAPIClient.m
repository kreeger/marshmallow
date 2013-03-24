#import "BDKAPIClient.h"

#import "NSString+BDKKit.h"
#import <AFNetworking/AFNetworking.h>

@implementation BDKAPIClient

#pragma mark - Initialization and singleton

- (id)initWithBaseURL:(NSURL *)url {
    if ((self = [super initWithBaseURL:url])) {
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Accept-Language" value:@"en-us"];
        [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAPIReachabilityChanged object:nil];
        }];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return self;
}

+ (NSString *)baseURL {
    return @"";
}

#pragma mark - Helpers

+ (NSString *)buildRequestStringForSegments:(NSArray *)segments {
    NSArray *newSegments = [segments map:^NSString *(id segment) {
        return [segment isKindOfClass:[NSString class]] ? [segment stringByUrlEncoding] : [segment stringValue];
    }];
    return [newSegments join:@"/"];
}

+ (void)cancelRequestsWithPrefix:(NSString *)prefix { }

@end
