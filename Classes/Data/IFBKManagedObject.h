#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@class IFBKCFModel;

/**
 A standard NSManagedObject class that gives the rest of our Core Data models some cohesiveness.
 */
@interface IFBKManagedObject : NSManagedObject

/**
 A common implementation to return entity name. Used in fetches and the like. Default implementation returns a string
 version of the name of the class.
 
 @return The string of the name of the entity.
 */
+ (NSString *)entityName;

/**
 A common implementation to return an entity description object. Used in fetches and the like.
 
 @param context The context to use when providing an entity description.
 @return A proper entity description.
 */
+ (NSEntityDescription *)entityDescriptionForContext:(NSManagedObjectContext *)context;

/**
 A common implementation to return an easy-to-use fetch request object.
 
 @return An NSFetchRequest already set to the current class's entity name.
 */
+ (NSFetchRequest *)fetchRequest;

/**
 Convenience method for finding a set of matching objects using a predicate.
 
 @param predicate The instance of an NSPredicate to use when fetching objects.
 @param context The managed object context in which to search for results.
 @return An array of found objects.
 */
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/**
 Finds a whole bunch of objects based on a set of identifiers.
 
 @param identifiers The list of identifiers to use in the predicate.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An array with the resulting models.
 */
+ (NSArray *)findAllWithIdentifiers:(NSArray *)identifiers inContext:(NSManagedObjectContext *)context;

/**
 Finds a whole bunch of objects based on a set of identifiers.
 
 @param identifiers The list of identifiers to use in the predicate.
 @param sortedBy The key path to sort by.
 @param ascending If `YES`, sort in order.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An array with the resulting models.
 */
+ (NSArray *)findAllWithIdentifiers:(NSArray *)identifiers
                           sortedBy:(NSString *)sortedBy
                          ascending:(BOOL)ascending
                          inContext:(NSManagedObjectContext *)context;

/**
 Convenience method for grabbing all objects with a sort parameter.
 
 @param sortProperty The string of the keypath by which to sort.
 @param flag If YES, the sort operation will be performed in an ascending manner.
 @param context The managed object context in which to search for results.
 @return An array of found objects, sorted.
 */
+ (NSArray *)findAllSortedBy:(NSString *)sortProperty ascending:(BOOL)flag inContext:(NSManagedObjectContext *)context;

/**
 The main method to call when dealing with a Core Data representation of an API model.
 
 @param model The API model to use in looking up to see if it exists.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
+ (instancetype)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Initializes this model with a IFBKCFModel.
 
 @param model The IFBKCFModel with which to create this model.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
+ (instancetype)modelWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Deletes all with the entity type in the database.
 */
+ (void)truncateAll;

/**
 Initializes this model with a IFBKCFModel.
 
 @param model The IFBKCFModel with which to create this model.
 @param context the managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
- (instancetype)initWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Updates internal parameters with a IFBKCFModel instance; this must be implemented by child classes.
 
 @param model The IFBKCFModel with which to update this model.
 */
- (void)updateWithIFBKCFModel:(IFBKCFModel *)model;

@end
