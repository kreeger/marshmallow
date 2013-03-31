#import <Foundation/Foundation.h>

/** A base Campfire API model from which all others inherit. Children will have simple data types (nothing custom).
 */
@interface BDKCFModel : NSObject

/** A dictionary version of this model that will be used in POSTing or PUTting against the API.
 */
@property (readonly) NSDictionary *asApiData;

/** Override in child class. A key/value set of api keys to local variable names for a model.
 *  @return a dictionary of api-key / local variable name mappings.
 */
+ (NSDictionary *)apiMappingHash;

+ (id)modelWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
