#import "IFBKMessageSet.h"
#import "IFBKUser.h"
#import "IFBKCFMessage.h"

@interface IFBKMessageSet ()

/**
 The user ID-specific component of the most recent dictionary key.
 */
@property (readonly) NSString *mostRecentUserId;

@property (readonly) NSString *mostRecentMessageType;

/**
 Generates a key string for a message. This is equivalent to the message ID and user ID separated by a hyphen.
 
 @param message The instance of the message.
 @returns A string that identifies the message (for use as a dictionary key).
 */
- (NSString *)keyStringForMessage:(IFBKCFMessage *)message;

@end

@implementation IFBKMessageSet

+ (id)messageSet {
    return [[self alloc] init];
}

#pragma mark - Properties

- (NSString *)mostRecentUserId {
    return [self userIdStringFromSection:([self count] - 1)];
}

- (NSString *)mostRecentMessageType {
    return [self messageTypeFromSection:([self count] - 1)];
}

#pragma mark - Public methods

- (void)addMessage:(IFBKCFMessage *)message {
    // If most recent key (user) is the same as this message's sender, then add this message to the key's array value.
    // TODO: guard against -[NSNull stringValue]: unrecognized selector sent to instance
    NSNumber *identifier = [(NSNull *)message.userIdentifier isEqual:[NSNull null]] ? @0 : message.userIdentifier;
    if ([[identifier stringValue] isEqualToString:self.mostRecentUserId] &&
        [message.type isEqualToString:self.mostRecentMessageType]) {
        [self[[self.sortedKeys lastObject]] addObject:message];
    } else {
        // Otherwise, append a new key to the messages ordered dictionary with a fresh mutable array with this message
        // at the beginning of it.
        [self addEntriesFromDictionary:@{[self keyStringForMessage:message]: [NSMutableArray arrayWithArray:@[message]]}];
    }
}

- (IFBKCFMessage *)messageAtSection:(NSInteger)section row:(NSInteger)row {
    NSArray *messages = [self messagesForSection:section];
    return [messages count] ? messages[row] : nil;
}

- (NSString *)userIdStringFromSection:(NSInteger)section {
    return [self.sortedKeys count] ? [self.sortedKeys[section] componentsSeparatedByString:@"-"][2] : nil;
}

- (NSString *)messageTypeFromSection:(NSInteger)section {
    return [self.sortedKeys count] ? [self.sortedKeys[section] componentsSeparatedByString:@"-"][1] : nil;
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
    return [@[message.identifier, message.type, identifier] componentsJoinedByString:@"-"];
}

@end
