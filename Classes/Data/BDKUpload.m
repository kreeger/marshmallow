#import "BDKUpload.h"
#import "BDKCFUpload.h"

#import "NSString+BDKKit.h"

@implementation BDKUpload

@dynamic fullUrlValue;

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKCFUpload *upload = (BDKCFUpload *)model;
    NSArray *attributes = @[@"identifier", @"name", @"roomIdentifier", @"userIdentifier", @"byteSize", @"contentType",
                            @"fullUrl", @"createdAt"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[upload valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Property

- (NSURL *)fullUrlValue {
    return self.fullUrl.urlValue;
}

@end