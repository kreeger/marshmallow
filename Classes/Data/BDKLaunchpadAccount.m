#import "BDKLaunchpadAccount.h"
#import "BDKLPAccount.h"

@implementation BDKLaunchpadAccount

@dynamic type, hrefUrl;

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKLPAccount *account = (BDKLPAccount *)model;
    NSArray *attributes = @[@"identifier", @"href", @"name", @"product"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

+ (NSDictionary *)accountTypeMappings
{
    return @{@"bcx": @(BDKLaunchpadAccountTypeBasecamp),
             @"basecamp": @(BDKLaunchpadAccountTypeBasecampClassic),
             @"campfire": @(BDKLaunchpadAccountTypeCampfire),
             @"highrise": @(BDKLaunchpadAccountTypeHighrise),
             @"backpack": @(BDKLaunchpadAccountTypeBackpack),};
}

- (BDKLaunchpadAccountType)type
{
    NSNumber *type = [[self class] accountTypeMappings][self.product];
    return type ? type.integerValue : BDKLaunchpadAccountTypeUnknown;
}

@end
