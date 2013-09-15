#import "IFBKLaunchpadAccount.h"
#import "IFBKAccount.h"
#import "IFBKUser.h"

#import <IFBKThirtySeven/IFBKLPAccount.h>

@implementation IFBKLaunchpadAccount

@dynamic href;
@dynamic identifier;
@dynamic name;
@dynamic product;
@dynamic campfireAccount;
@dynamic user;

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model {
    IFBKLPAccount *account = (IFBKLPAccount *)model;
    NSArray *attributes = @[@"identifier", @"href", @"name", @"product"];
    for (NSString *attribute in attributes) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }
}

#pragma mark - Properties

+ (NSDictionary *)accountTypeMappings {
    return @{@"bcx": @(IFBKLaunchpadAccountTypeBasecamp),
             @"basecamp": @(IFBKLaunchpadAccountTypeBasecampClassic),
             @"campfire": @(IFBKLaunchpadAccountTypeCampfire),
             @"highrise": @(IFBKLaunchpadAccountTypeHighrise),
             @"backpack": @(IFBKLaunchpadAccountTypeBackpack),};
}

- (IFBKLaunchpadAccountType)type {
    NSNumber *type = [[self class] accountTypeMappings][self.product];
    return type ? [type integerValue] : IFBKLaunchpadAccountTypeUnknown;
}

- (NSURL *)hrefUrl {
    return [NSURL URLWithString:self.href];
}

@end
