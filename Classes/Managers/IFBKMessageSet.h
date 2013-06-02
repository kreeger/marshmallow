#import "IFBKOrderedDictionary.h"

@class IFBKCFMessage, IFBKUser;

/** Handles the more complex logic for adding and sorting and grouping all the loaded messages for a room.
 */
@interface IFBKMessageSet : IFBKOrderedDictionary

/** Initializes a fresh message set.
 *  
 *  @returns An instance of this class.
 */
+ (id)messageSet;

/** Files away an incoming API message under the most recent key if it matches the sender or a new key if it doesn't.
 *
 *  @param message The API message to store.
 */
- (void)addMessage:(IFBKCFMessage *)message;

/** Gets a message for a given section and row - in other words, an `NSIndexPath`.
 *  
 *  @param indexPath The index path for which to store the message.
 *  @returns The Campfire message.
 */
- (IFBKCFMessage *)messageAtIndexPath:(NSIndexPath *)indexPath;

/** Gets the user belonging to the messages at a given section.
 *
 *  @param section The section for which to retrieve the user.
 *  @returns The user object for that section.
 */
- (IFBKUser *)userForSection:(NSInteger)section;

/** Gets the array of messages for a given section.
 *
 *  @param section The section for which to retrieve messages.
 *  @returns The array of messages at that section.
 */
- (NSArray *)messagesForSection:(NSInteger)section;

@end
