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
            [self setValue:dictionary[key] forKeyPath:[[self class] apiMappingHash][key]];
        }];
    }

    return self;
}

@end
