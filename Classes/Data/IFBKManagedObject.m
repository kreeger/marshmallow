#import "IFBKManagedObject.h"
#import "IFBKCFModel.h"

@implementation IFBKManagedObject

#pragma mark - Class methods

+ (NSString *)entityName {
    return NSStringFromClass([self class]);
}

+ (NSEntityDescription *)entityDescriptionForContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSFetchRequest *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetch = [self fetchRequest];
    fetch.predicate = predicate;
    fetch.returnsObjectsAsFaults = NO;
    NSError *error = nil;
    return [context executeFetchRequest:fetch error:&error];
}

+ (NSArray *)findAllWithIdentifiers:(NSArray *)identifiers inContext:(NSManagedObjectContext *)context {
    return [self findAllWithIdentifiers:identifiers sortedBy:nil ascending:YES inContext:context];
}

+ (NSArray *)findAllWithIdentifiers:(NSArray *)identifiers
                           sortedBy:(NSString *)sortedBy
                          ascending:(BOOL)ascending
                          inContext:(NSManagedObjectContext *)context {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier in (%@)", identifiers];
    if (sortedBy) {
        return [self findAllSortedBy:sortedBy ascending:ascending withPredicate:pred inContext:context];
    } else {
        return [self findWithPredicate:pred inContext:context];
    }
}

+ (NSArray *)findAllSortedBy:(NSString *)sortProperty ascending:(BOOL)flag inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetch = [self fetchRequest];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortProperty ascending:flag]];
    NSError *error = nil;
    return [context executeFetchRequest:fetch error:&error];
}

+ (instancetype)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context {
    if (!context) {
        context = [NSManagedObjectContext defaultContext];
    }
    
    NSNumber *apiIdentifier = [model valueForKeyPath:@"identifier"];
    IFBKManagedObject *found = [self findFirstByAttribute:@"identifier" withValue:apiIdentifier inContext:context];
    if (found) {
        [found updateWithIFBKCFModel:model];
        return found;
    } else {
        return [self modelWithIFBKCFModel:model inContext:context];
    }
}

+ (instancetype)modelWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithIFBKCFModel:model inContext:context];
}

+ (void)truncateAll {
    // TODO: implement
}

#pragma mark - Instance methods

- (instancetype)initWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context {
    if (!context) context = [NSManagedObjectContext defaultContext];
    NSEntityDescription *entity = [[self class] entityDescriptionForContext:context];
    if ((self = [super initWithEntity:entity insertIntoManagedObjectContext:context])) {
        [self updateWithIFBKCFModel:model];
    }
    return self;
}

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model { }

@end
