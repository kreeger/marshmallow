#import "IFBKLaunchpadAccount.h"
#import "BDKLPAccount.h"

@implementation IFBKLaunchpadAccount

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
    return @{@"bcx": @(IFBKLaunchpadAccountTypeBasecamp),
             @"basecamp": @(IFBKLaunchpadAccountTypeBasecampClassic),
             @"campfire": @(IFBKLaunchpadAccountTypeCampfire),
             @"highrise": @(IFBKLaunchpadAccountTypeHighrise),
             @"backpack": @(IFBKLaunchpadAccountTypeBackpack),};
}

- (IFBKLaunchpadAccountType)type
{
    NSNumber *type = [[self class] accountTypeMappings][self.product];
    return type ? type.integerValue : IFBKLaunchpadAccountTypeUnknown;
}

- (NSURL *)hrefUrl
{
    return [NSURL URLWithString:self.href];
}

@end
