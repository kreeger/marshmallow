#import "IFBKMessageSet.h"
#import "IFBKUser.h"
#import "IFBKCFMessage.h"

@interface IFBKMessageSet ()

/** The user ID-specific component of the most recent dictionary key.
 */
@property (readonly) NSString *mostRecentUserId;

/** Generates a key string for a message. This is equivalent to the message ID and user ID separated by a hyphen.
 *
 *  @param message The instance of the message.
 *  @returns A string that identifies the message (for use as a dictionary key).
 */
- (NSString *)keyStringForMessage:(IFBKCFMessage *)message;

/** Determines the user ID stored in the key string and returns it.
 *
 *  @param section The section for which to retrieve the user from the key string.
 *  @returns A string that identifies the user (for use in database lookups).
 */
- (NSString *)userIdStringFromSection:(NSInteger)section;

@end

@implementation IFBKMessageSet

+ (id)messageSet {
    return [[self alloc] init];
}

#pragma mark - Properties

- (NSString *)mostRecentUserId {
    return [self userIdStringFromSection:(self.count - 1)];
}

#pragma mark - Public methods

- (void)addMessage:(IFBKCFMessage *)message {
    // If most recent key (user) is the same as this message's sender, then add this message to the key's array value.
    // TODO: guard against -[NSNull stringValue]: unrecognized selector sent to instance
    NSNumber *identifier = [(NSNull *)message.userIdentifier isEqual:[NSNull null]] ? @0 : message.userIdentifier;
    if ([[identifier stringValue] isEqualToString:self.mostRecentUserId]) {
        [self[[self.sortedKeys lastObject]] addObject:message];
    } else {
        // Otherwise, append a new key to the messages ordered dictionary with a fresh mutable array with this message
        //     at the beginning of it.
        [self addEntriesFromDictionary:@{[self keyStringForMessage:message]: [NSMutableArray arrayWithArray:@[message]]}];
    }
}

- (IFBKCFMessage *)messageAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *messages = [self messagesForSection:indexPath.section];
    return [messages count] ? messages[indexPath.row] : nil;
}

- (IFBKUser *)userForSection:(NSInteger)section {
    if ([[self sortedKeys] count]) {
        NSString *userId = [self userIdStringFromSection:section];
        return [userId isEqualToString:@"0"] ? nil : [IFBKUser findFirstByAttribute:@"identifier" withValue:userId];
    } else {
        return nil;
    }
}

- (NSArray *)messagesForSection:(NSInteger)section {
    if ([[self sortedKeys] count]) {
        NSString *userId = [self sortedKeys][section];
        return self[userId];
    } else {
        return @[];
    }
}

#pragma mark - Private methods

- (NSString *)keyStringForMessage:(IFBKCFMessage *)message {
    NSNumber *identifier = [(NSNull *)message.userIdentifier isEqual:[NSNull null]] ? @0 : message.userIdentifier;
    return [@[message.identifier, identifier] componentsJoinedByString:@"-"];
}

- (NSString *)userIdStringFromSection:(NSInteger)section {
    return [self.sortedKeys count] ? [[self.sortedKeys[section] componentsSeparatedByString:@"-"] lastObject] : nil;
}

@end
