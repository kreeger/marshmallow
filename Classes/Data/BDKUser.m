#import "BDKUser.h"
#import "BDKCFUser.h"
#import "NSString+BDKKit.h"

@implementation BDKUser

@dynamic userType;

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKCFUser *user = (BDKCFUser *)model;
    NSArray *attributes = @[@"identifier", @"name", @"emailAddress", @"admin", @"createdAt", @"type", @"avatarUrl"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[user valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

+ (NSDictionary *)userTypeMappings
{
    return @{@"Member": @(BDKUserTypeMember),
             @"Guest": @(BDKUserTypeGuest),};
}

- (BDKUserType)userType
{
    NSNumber *type = [[self class] userTypeMappings][self.type];
    return type ? type.integerValue : BDKUserTypeUnknown;
}

- (NSURL *)avatarUrlValue {
    return self.avatarUrl.urlValue;
}

@end
