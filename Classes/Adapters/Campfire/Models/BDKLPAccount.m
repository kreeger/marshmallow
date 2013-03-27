#import "BDKLPAccount.h"
#import "NSString+BDKKit.h"

@implementation BDKLPAccount

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"name": @"name",};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        if ([dictionary[@"product"] isEqualToString:@"bcx"]) _type = BDKLPAccountTypeBasecamp;
        else if ([dictionary[@"product"] isEqualToString:@"basecamp"]) _type = BDKLPAccountTypeBasecampClassic;
        else if ([dictionary[@"product"] isEqualToString:@"campfire"]) _type = BDKLPAccountTypeCampfire;
        else if ([dictionary[@"product"] isEqualToString:@"highrise"]) _type = BDKLPAccountTypeHighrise;
        else if ([dictionary[@"product"] isEqualToString:@"backpack"]) _type = BDKLPAccountTypeBackpack;
        else _type = BDKLPAccountTypeUnknown;
        _hrefUrl = [dictionary[@"href"] urlValue];
    }

    return self;
}

@end
