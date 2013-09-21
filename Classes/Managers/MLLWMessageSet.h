#import <Foundation/Foundation.h>

#import "MLLWOrderedDictionary.h"
#import "IFBKCFMessage.h"

@class MLLWUser;

/**
 Handles the more complex logic for adding and sorting and grouping all the loaded messages for a room.
 */
@interface MLLWMessageSet : MLLWOrderedDictionary

/**
 Initializes a fresh message set.
 
 @return An instance of this class.
 */
+ (instancetype)messageSet;

/**
 Files away an incoming API message under the most recent key if it matches the sender or a new key if it doesn't.
 
 @param message The API message to store.
 @return If message was successfully added, `YES`. Otherwise, `NO`.
 */
- (BOOL)addMessage:(IFBKCFMessage *)message;

/**
 Gets a message for a given section and row - in other words, an `NSIndexPath`. This is pulled into section/row
 to reduce dependencies on UIKit/AppKit.
 
 @param section The section of the index path for which to store the message.
 @param row The row in the section.
 @return The Campfire message.
 */
- (IFBKCFMessage *)messageForSection:(NSInteger)section row:(NSInteger)row;

/**
 Determines the date stored in the dictionary key at an index and returns it.
 
 @param section The section for which to retrieve the date from the key.
 @return A date.
 */
- (NSDate *)dateForSection:(NSInteger)section;

/**
 Determines the display date stored in the key and returns it.
 
 @param section The section for which to retrieve the display date.
 @return A date formatted as a string using the current locale.
 */
- (NSString *)displayDateForSection:(NSInteger)section;

/**
 Gets the array of messages for a given section.
 
 @param section The section for which to retrieve messages.
 @return The array of messages at that section.
 */
- (NSArray *)messagesForSection:(NSInteger)section;

@end
