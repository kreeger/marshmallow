#import "MLLWManagedObject.h"
#import "IFBKCFModel.h"
#import "MLLWCoreDataStore.h"

@implementation MLLWManagedObject

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

+ (instancetype)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context {
    if (!context) {
        context = [NSManagedObjectContext defaultContext];
    }
    
    NSNumber *apiIdentifier = [model valueForKeyPath:@"identifier"];
    MLLWManagedObject *found = [self findByIdentifier:apiIdentifier inContext:context];
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

@implementation MLLWManagedObject (Finders)

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate {
    return [self findWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [self findWithPredicate:predicate sortedBy:nil ascending:NO inContext:context];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortProperty
                     ascending:(BOOL)flag
                     inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetch = [self fetchRequest];
    if (sortProperty) {
        fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortProperty ascending:flag]];
    }
    if (predicate) {
        fetch.predicate = predicate;
    }
    NSError *error = nil;
    return [context executeFetchRequest:fetch error:&error];
}

+ (instancetype)findByIdentifier:(NSNumber *)identifier inContext:(NSManagedObjectContext *)context {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    NSArray *results = [self findWithPredicate:pred sortedBy:nil ascending:NO inContext:context];
    if ([results count] > 0) {
        return [results firstObject];
    } else {
        return nil;
    }
}

@end
