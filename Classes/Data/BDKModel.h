#import <CoreData/CoreData.h>

@class BDKCFModel;

/** A standard NSManagedObject class that gives the rest of our Core Data models some cohesiveness.
 */
@interface BDKModel : NSManagedObject

/** Initializes this model with a BDKCFModel.
 *  @param model The BDKCFModel with which to create this model.
 *  @return an instance of self.
 */
+ (id)modelWithBDKCFModel:(BDKCFModel *)model;

/** Initializes this model with a BDKCFModel.
 *  @param model The BDKCFModel with which to create this model.
 *  @return an instance of self.
 */
- (id)initWithBDKCFModel:(BDKCFModel *)model;

/** Updates internal parameters with a BDKCFModel instance.
 *  @param model The BDKCFModel with which to update this model.
 */
- (void)updateWithBDKCFModel:(BDKCFModel *)model;

@end
