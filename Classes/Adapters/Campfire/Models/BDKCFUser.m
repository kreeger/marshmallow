#import "BDKCFUser.h"
#import "NSString+BDKKit.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>


@implementation BDKCFUser

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"name": @"name",
             @"email_address": @"emailAddress",
             @"admin": @"admin",
             @"type": @"type",
             @"avatar_url": @"avatarUrl"};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;
    }

    return self;
}

@end
