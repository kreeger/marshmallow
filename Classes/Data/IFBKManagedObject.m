#import "IFBKManagedObject.h"
#import "IFBKCFModel.h"
#import "IFBKCoreDataStore.h"

#import "IFBKManagedObject+Finders.h"

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

+ (instancetype)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context {
    if (!context) {
        context = [NSManagedObjectContext defaultContext];
    }
    
    NSNumber *apiIdentifier = [model valueForKeyPath:@"identifier"];
    IFBKManagedObject *found = [self findByIdentifier:apiIdentifier inContext:context];
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
