#import "BDKModel.h"
#import "BDKCFModel.h"

@implementation BDKModel

+ (id)createOrUpdateWithModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    unless (context) context = [NSManagedObjectContext defaultContext];
    NSNumber *apiIdentifier = [model valueForKeyPath:@"identifier"];
    BDKModel *found = [self findFirstByAttribute:@"identifier" withValue:apiIdentifier inContext:context];
    if (found) {
        [found updateWithBDKCFModel:model];
        return found;
    } else {
        return [self modelWithBDKCFModel:model inContext:context];
    }
}

+ (id)modelWithBDKCFModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    return [[self alloc] initWithBDKCFModel:model inContext:context];
}

- (id)initWithBDKCFModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    unless (context) context = [NSManagedObjectContext defaultContext];
    if ((self = [[self class] createInContext:context])) {
        [self updateWithBDKCFModel:model];
    }
    return self;
}

- (void)updateWithBDKCFModel:(BDKCFModel *)model { }

@end
