#import <Foundation/Foundation.h>

#define kBDK37SignalsClientKey @"37SignalsClientKey"
#define kBDK37SignalsClientSecret @"37SignalsClientSecret"
#define kBDK37SignalsRedirectURI @"37SignalsRedirectURI"

@interface BDKAPIKeyManager : NSObject

/** Grabs a singleton instance of the adapter.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

/** Grabs an API key given a string key for it.
 *  @param key the key to use to look up the API key.
 *  @return a string value for a key.
 */
+ (NSString *)apiKeyForKey:(NSString *)key;

@end
