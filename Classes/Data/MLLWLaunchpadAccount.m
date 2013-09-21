#import "MLLWLaunchpadAccount.h"
#import "MLLWAccount.h"
#import "MLLWUser.h"

#import <IFBKThirtySeven/IFBKLPAccount.h>

#import "MLLWManagedObject.h"

@implementation MLLWLaunchpadAccount

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
    return @{@"bcx": @(MLLWLaunchpadAccountTypeBasecamp),
             @"basecamp": @(MLLWLaunchpadAccountTypeBasecampClassic),
             @"campfire": @(MLLWLaunchpadAccountTypeCampfire),
             @"highrise": @(MLLWLaunchpadAccountTypeHighrise),
             @"backpack": @(MLLWLaunchpadAccountTypeBackpack),};
}

- (MLLWLaunchpadAccountType)type {
    NSNumber *type = [[self class] accountTypeMappings][self.product];
    return type ? [type integerValue] : MLLWLaunchpadAccountTypeUnknown;
}

- (NSURL *)hrefUrl {
    return [NSURL URLWithString:self.href];
}

@end

@implementation MLLWLaunchpadAccount (Finders)

+ (NSArray *)campfireAccounts {
    return [MLLWLaunchpadAccount findWithPredicate:[NSPredicate predicateWithFormat:@"product = %@", @"campfire"]];
}

@end