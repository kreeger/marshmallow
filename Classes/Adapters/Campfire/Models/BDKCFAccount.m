#import "BDKCFAccount.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

@implementation BDKCFAccount

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"name": @"name",
             @"subdomain": @"subdomain",
             @"plan": @"plan",
             @"owner_id": @"ownerIdentifier",
             @"time_zone": @"timeZone",
             @"storage": @"storage"};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        _updatedAt = [formatter dateFromString:dictionary[@"updated_at"]];
        formatter = nil;
    }

    return self;
}

@end
