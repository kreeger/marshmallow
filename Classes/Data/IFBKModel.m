#import "IFBKModel.h"
#import "IFBKCFModel.h"

@implementation IFBKModel

+ (id)findAllWithIdentifiers:(NSArray *)identifiers inContext:(NSManagedObjectContext *)context
{
    return [self findAllWithIdentifiers:identifiers sortedBy:nil ascending:YES inContext:context];
}

+ (id)findAllWithIdentifiers:(NSArray *)identifiers
                    sortedBy:(NSString *)sortedBy
                   ascending:(BOOL)ascending
                   inContext:(NSManagedObjectContext *)context
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier in (%@)", identifiers];
    if (sortedBy)
        return [self findAllSortedBy:sortedBy ascending:ascending withPredicate:pred inContext:context];
    else
        return [self findAllWithPredicate:pred inContext:context];
}

+ (id)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    unless (context) context = [NSManagedObjectContext defaultContext];
    NSNumber *apiIdentifier = [model valueForKeyPath:@"identifier"];
    IFBKModel *found = [self findFirstByAttribute:@"identifier" withValue:apiIdentifier inContext:context];
    if (found) {
        [found updateWithIFBKCFModel:model];
        return found;
    } else {
        return [self modelWithIFBKCFModel:model inContext:context];
    }
}

+ (id)modelWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    return [[self alloc] initWithIFBKCFModel:model inContext:context];
}

- (id)initWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context
{
    unless (context) context = [NSManagedObjectContext defaultContext];
    if ((self = [[self class] createInContext:context])) {
        [self updateWithIFBKCFModel:model];
    }
    return self;
}

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model { }

@end
