#import "BDKCFModel.h"

@implementation BDKCFModel

+ (NSDictionary *)apiMappingHash
{
    return @{};
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super init])) {
        [[dictionary allKeys] each:^(NSString *key) {
            unless ([[self class] apiMappingHash][key]) return;
            id value = dictionary[key];// == (id)[NSNull null] ? nil : dictionary[key];
            [self setValue:value forKeyPath:[[self class] apiMappingHash][key]];
        }];
    }

    return self;
}

@end
