#import <Foundation/Foundation.h>

#import "IFBKOrderedDictionary.h"
#import "IFBKCFMessage.h"

@class IFBKUser;

/**
 Handles the more complex logic for adding and sorting and grouping all the loaded messages for a room.
 */
@interface IFBKMessageSet : IFBKOrderedDictionary

/**
 Initializes a fresh message set.
 
 @returns An instance of this class.
 */
+ (id)messageSet;

/**
 Files away an incoming API message under the most recent key if it matches the sender or a new key if it doesn't.
 
 @param message The API message to store.
 @return If message was successfully added, `YES`. Otherwise, `NO`.
 */
- (BOOL)addMessage:(IFBKCFMessage *)message;

/**
 Gets a message for a given section and row - in other words, an `NSIndexPath`. This is pulled into section/row
 to reduce dependencies on UIKit.
 
 @param section The section of the index path for which to store the message.
 @param row The row in the section.
 @returns The Campfire message.
 */
- (IFBKCFMessage *)messageAtSection:(NSInteger)section row:(NSInteger)row;

/**
 Determines the user ID stored in the key string and returns it.
 
 @param section The section for which to retrieve the user from the key string.
 @returns A string that identifies the user (for use in database lookups).
 */
- (NSString *)userIdStringFromSection:(NSInteger)section;

/**
 Determines the message type stored in the key string and returns it.
 
 @param section The section for which to retrieve the message type from the key string.
 @return The message type for the first message in the section.
 */
- (NSString *)messageTypeFromSection:(NSInteger)section;

/**
 Gets the array of messages for a given section.
 
 @param section The section for which to retrieve messages.
 @returns The array of messages at that section.
 */
- (NSArray *)messagesForSection:(NSInteger)section;

@end
