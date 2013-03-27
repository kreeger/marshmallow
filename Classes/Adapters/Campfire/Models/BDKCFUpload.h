#import "BDKCFModel.h"

@interface BDKCFUpload : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *roomIdentifier;
@property (strong, nonatomic) NSNumber *userIdentifier;
@property (strong, nonatomic) NSNumber *byteSize;
@property (strong, nonatomic) NSString *contentType;
@property (strong, nonatomic) NSURL *fullUrl;
@property (strong, nonatomic) NSDate *createdAt;

@end
