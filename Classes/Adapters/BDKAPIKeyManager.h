#import <Foundation/Foundation.h>

extern NSString * const BDK37SignalsClientKey;
extern NSString * const BDK37SignalsClientSecret;
extern NSString * const BDK37SignalsRedirectURI;

/**
 A handy class to retrieve a plethora of API keys stored in a specific `plist` file.
 NOTE: the file at `Resources/APIKeys.plist` must exist.
 */
@interface BDKAPIKeyManager : NSObject

/**
 Grabs a singleton instance of the adapter.

 @return singleton instance.
 */
+ (instancetype)sharedInstance;

/**
 Grabs an API key given a string key for it.

 @param key the key to use to look up the API key.
 @return a string value for a key.
 */
+ (NSString *)apiKeyForKey:(NSString *)key;

@end
