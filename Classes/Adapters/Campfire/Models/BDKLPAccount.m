#import "BDKLPAccount.h"
#import "NSString+BDKKit.h"

@implementation BDKLPAccount

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"name": @"name",
             @"href": @"href",
             @"product": @"product"};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
    }

    return self;
}

@end
