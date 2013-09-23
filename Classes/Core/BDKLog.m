#import "BDKLog.h"
#import <libkern/OSAtomic.h>

#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDTTYLogger.h>

/** Most of this code is from https://github.com/robbiehanson/CocoaLumberjack/wiki/CustomFormatters
 */
@implementation BDKLog

+ (void)configureLogging {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDTTYLogger sharedInstance].logFormatter = [BDKLog new];
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.60 green:0.81 blue:0.92 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.46 green:1.00 blue:0.48 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_API];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:0.60 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_UI];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.87 green:0.67 blue:0.53 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_DATA];
}

- (NSString *)stringFromDate:(NSDate *)date {
    int32_t loggerCount = OSAtomicAdd32(0, &_atomicLoggerCount);
    
    if (loggerCount <= 1) {
        // Single-threaded mode.
        
        if (_threadUnsafeDateFormatter == nil) {
            _threadUnsafeDateFormatter = [NSDateFormatter new];
            [_threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            // [_threadUnsafeDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
            [_threadUnsafeDateFormatter setDateFormat:@"HH:mm:ss:SSS"];
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
