#import "BDKCFMessage.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

@implementation BDKCFMessage

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"room_id": @"roomIdentifier",
             @"user_id": @"userIdentifier",
             @"body": @"body",
             @"type": @"type"};
}

+ (id)messageWithBody:(NSString *)body type:(NSString *)type
{
    return [[self alloc] initWithBody:body type:type];
}

- (id)initWithBody:(NSString *)body type:(NSString *)type
{
    if (self = [super init]) {
        _body = body;
        _type = type;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;

        _starred = [dictionary[@"starred"] boolValue];
    }

    return self;
}

#pragma mark - Properties

- (NSDictionary *)asApiData
{
    // TODO: Convert line breaks to &#xA;
    return @{@"message": @{@"body": self.body, @"type": self.type}};
}

@end
