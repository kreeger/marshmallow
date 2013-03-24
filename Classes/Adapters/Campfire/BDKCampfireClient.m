#import "BDKCampfireClient.h"

#import "NSString+BDKKit.h"
#import <AFNetworking/AFHTTPRequestOperation.h>

@implementation BDKCampfireClient

#pragma mark - Initialization and singleton

+ (id)sharedInstance {
    static BDKCampfireClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BDKCampfireClient alloc] initWithBaseURL:nil];
    });
    return __sharedInstance;
}

+ (void)cancelRequestsWithPrefix:(NSString *)prefix {
    NSArray *queue = [[self sharedInstance] operationQueue].operations;
    NSString *requestMatch = [NSString stringWithFormat:@"%@%@", [self baseURL], prefix];
    [queue each:^(AFHTTPRequestOperation *operation) {
        if ([operation.request.URL.description hasPrefix:requestMatch]) [operation cancel];
    }];
}

@end
