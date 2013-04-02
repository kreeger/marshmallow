#import "BDKCFUser.h"
#import "NSString+BDKKit.h"


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
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = kBDKDateFormatCampfire;
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;
    }

    return self;
}

@end