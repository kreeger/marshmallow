#import <Foundation/Foundation.h>

/** These are handy wrappers around various messages that interact with strings.
 */
@interface NSString (BDKKit)

/** Checks for nil, NSNull, or blank.
 *  @return `YES` if string is falsy.
 */
- (BOOL)isEmptyOrNull;

/** Shorthand for NSURL's `URLWithString:`.
 *  @return a URL with self.
 */
- (NSURL *)urlValue;

/** URL-encodes a string.
 *  @return a URL-encoded version of self.
 */
- (NSString *)stringByUrlEncoding;

@end
