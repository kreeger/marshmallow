#import <CoreData/CoreData.h>

@class BDKCFModel;

/** A standard NSManagedObject class that gives the rest of our Core Data models some cohesiveness.
 */
@interface BDKModel : NSManagedObject

/** The main method to call when dealing with a Core Data representation of an API model.
 *  @param model the API model to use in looking up to see if it exists.
 *  @param context the managed object context; can be nil (if so, the default is used).
 *  @returns an instance of self.
 */
+ (id)createOrUpdateWithModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context;

/** Initializes this model with a BDKCFModel.
 *  @param model The BDKCFModel with which to create this model.
 *  @param context the managed object context; can be nil (if so, the default is used).
 *  @returns an instance of self.
 */
+ (id)modelWithBDKCFModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context;

/** Initializes this model with a BDKCFModel.
 *  @param model The BDKCFModel with which to create this model.
 *  @param context the managed object context; can be nil (if so, the default is used).
 *  @returns an instance of self.
 */
- (id)initWithBDKCFModel:(BDKCFModel *)model inContext:(NSManagedObjectContext *)context;

/** Updates internal parameters with a BDKCFModel instance; this must be implemented by child classes.
 *  @param model The BDKCFModel with which to update this model.
 */
- (void)updateWithBDKCFModel:(BDKCFModel *)model;

@end
