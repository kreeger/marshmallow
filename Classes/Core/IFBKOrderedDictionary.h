#import <Foundation/Foundation.h>

/** A decorator around NSMutableDictionary that maintains the orders of its keys.
 *  Shamelessly copied from Matt Gallagher's post on Cocoa with Love. URL:
 *  http://cocoawithlove.com/2008/12/ordereddictionary-subclassing-cocoa.html
 */
@interface IFBKOrderedDictionary : NSMutableDictionary

/** Inserts an object into the dictionary for a key at a given index.
 *
 *  @param anObject The object to insert.
 *  @param aKey The key under which to store the object.
 *  @param anIndex The index at which to place the key.
 */
- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex;

/** Returns the key at a given index.
 *  
 *  @param anIndex The index for which to retrieve the key.
 *  @returns The key found at the index, or NSNotFound if... well, not found.
 */
- (id)keyAtIndex:(NSUInteger)anIndex;

/** Returns the reverse key enumerator.
 *
 *  @returns The reverse key enumerator for this class.
 */
- (NSEnumerator *)reverseKeyEnumerator;

/** Returns an array of the keys from the dictionary, sorted alphabetically.
 *
 *  @returns The sorted array of dictionary keys.
 */
- (NSArray *)sortedKeys;

@end
