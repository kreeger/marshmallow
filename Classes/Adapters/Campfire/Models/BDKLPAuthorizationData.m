#import "BDKLPAuthorizationData.h"
#import "BDKLPIdentity.h"
#import "BDKLPAccount.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

@implementation BDKLPAuthorizationData

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        _identity = [BDKLPIdentity modelWithDictionary:dictionary[@"identity"]];
        _accounts = [dictionary[@"accounts"] map:^BDKLPAccount *(NSDictionary *dict) {
            return [BDKLPAccount modelWithDictionary:dict];
        }];
        
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _expiresAt = [formatter dateFromString:dictionary[@"expires_at"]];
        formatter = nil;
    }

    return self;
}

@end
