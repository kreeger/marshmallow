#import "BDKLog.h"
#import <libkern/OSAtomic.h>

/** Most of this code is from https://github.com/robbiehanson/CocoaLumberjack/wiki/CustomFormatters
 */
@implementation BDKLog

- (NSString *)stringFromDate:(NSDate *)date {
    int32_t loggerCount = OSAtomicAdd32(0, &_atomicLoggerCount);
    
    if (loggerCount <= 1) {
        // Single-threaded mode.
        
        if (_threadUnsafeDateFormatter == nil) {
            _threadUnsafeDateFormatter = [NSDateFormatter new];
            _threadUnsafeDateFormatter.formatterBehavior = NSDateFormatterBehavior10_4;
            _threadUnsafeDateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss:SSS";
        }
        
        return [_threadUnsafeDateFormatter stringFromDate:date];
    }
    else {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        
        NSString *key = @"MyCustomFormatter_NSDateFormatter";
        
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        
        if (dateFormatter == nil) {
            dateFormatter = [NSDateFormatter new];
            dateFormatter.formatterBehavior = NSDateFormatterBehavior10_4;
            dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss:SSS";
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        
        return [dateFormatter stringFromDate:date];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->logFlag) {
        case LOG_FLAG_ERROR : logLevel = @"E"; break;
        case LOG_FLAG_WARN  : logLevel = @"W"; break;
        case LOG_FLAG_INFO  : logLevel = @"I"; break;
        default             : logLevel = @"V"; break;
    }
    
    NSString *dateAndTime = [self stringFromDate:(logMessage->timestamp)];
    NSString *logMsg = logMessage->logMsg;
    
    return [NSString stringWithFormat:@"%@ %@ | %@", logLevel, dateAndTime, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger {
    OSAtomicIncrement32(&_atomicLoggerCount);
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger {
    OSAtomicDecrement32(&_atomicLoggerCount);
}

@end
