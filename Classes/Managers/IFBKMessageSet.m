#import "IFBKMessageSet.h"
#import "IFBKUser.h"
#import "IFBKCFMessage.h"

#import "NSDate+Marshmallow.h"
#import "NSObject+Marshmallow.h"

@interface IFBKMessageSet ()

/**
 Holds an instance of a date formatter.
 */
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

/**
 Gets the NSNumber stored in a section and unboxes it into an NSTimeInterval.
 
 @param section The section for which to get the number key.
 @return A time interval representing the date for the section.
 */
- (NSTimeInterval)timeIntervalForSection:(NSInteger)section;

/**
 Generates a time interval for a message. This is the timestamp rounded down to the nearest day.
 
 @param message The instance of the message.
 @return A time interval that identifies the message (for use as a dictionary key).
 */
- (NSTimeInterval)timeIntervalForMessage:(IFBKCFMessage *)message;

@end

@implementation IFBKMessageSet

+ (instancetype)messageSet {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
    }
    return self;
}

#pragma mark - IFBKOrderedDictionary

- (NSArray *)sortedKeys {
    return [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark - Public methods

- (BOOL)addMessage:(IFBKCFMessage *)message {
    
    // TODO: Make this user-configurable.
    if (message.messageType == IFBKMessageTypeTimestamp) {
        return NO;
    }
    
    // If most recent time key (user) is the same as this message's date, then add this message to the key's array value.
    NSTimeInterval interval = [self timeIntervalForMessage:message];
    NSTimeInterval latest = [self timeIntervalForSection:[[self allKeys] count] - 1];
    
    if (interval == latest) {
        [self[[self.sortedKeys lastObject]] addObject:message];
    } else {
        // Otherwise, append a new key to the messages ordered dictionary with a fresh mutable array with this message
        // at the beginning of it.
        [self addEntriesFromDictionary:@{@(interval): [@[message] mutableCopy]}];
    }
    
    return YES;
}

- (IFBKCFMessage *)messageForSection:(NSInteger)section row:(NSInteger)row {
    NSArray *messages = [self messagesForSection:section];
    return [messages count] ? messages[row] : nil;
}

- (NSDate *)dateForSection:(NSInteger)section {
    if ([self.sortedKeys count]) return nil;
    return [NSDate dateWithTimeIntervalSince1970:[self timeIntervalForSection:section]];
}

- (NSString *)displayDateForSection:(NSInteger)section {
    
    return [self.dateFormatter stringFromDate:[self dateForSection:section]];
}

- (NSArray *)messagesForSection:(NSInteger)section {
    if ([[self sortedKeys] count]) {
        NSNumber *timeInterval = [self sortedKeys][section];
        return self[timeInterval];
    } else {
        return @[];
    }
}

#pragma mark - Private methods

- (NSTimeInterval)timeIntervalForSection:(NSInteger)section {
    if ([self.sortedKeys count] == 0) {
        return -1;
    } else {
        return [(NSNumber *)self.sortedKeys[section] doubleValue];
    }
}

- (NSTimeInterval)timeIntervalForMessage:(IFBKCFMessage *)message {
    return [[message.createdAt beginningOfDay] timeIntervalSince1970];
}

@end
