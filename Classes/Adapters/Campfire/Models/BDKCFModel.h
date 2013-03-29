#import <Foundation/Foundation.h>

/** A base Campfire API model from which all others inherit.
 */
@interface BDKCFModel : NSObject

@property (readonly) NSDictionary *asApiData;

/** Override in child class. A key/value set of api keys to local variable names for a model.
 *  @return a dictionary of api-key / local variable name mappings.
 */
+ (NSDictionary *)apiMappingHash;

+ (id)modelWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
