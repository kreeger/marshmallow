#import <Foundation/Foundation.h>

#define LOG_FLAG_API     (1 << 4)
#define LOG_FLAG_UI      (1 << 5)
#define LOG_FLAG_DATA    (1 << 6)

#define LOG_API       (ddLogLevel & LOG_FLAG_API)
#define LOG_UI        (ddLogLevel & LOG_FLAG_UI)
#define LOG_DATA      (ddLogLevel & LOG_FLAG_DATA)

#define DDLogAPI(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_API, 0, frmt, ##__VA_ARGS__)
#define DDLogUI(frmt, ...)    ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_UI, 0, frmt, ##__VA_ARGS__)
#define DDLogData(frmt, ...)  ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DATA, 0, frmt, ##__VA_ARGS__)

// #define LOG_FLAG_CUSTOM (LOG_FLAG_UI | LOG_FLAG_DATA)
#define LOG_FLAG_CUSTOM (LOG_FLAG_API | LOG_FLAG_UI | LOG_FLAG_DATA)

/**
 Handles custom logging setup with CocoaLumberjack (and formats outgoing logs, too).
 */
@interface BDKLog : NSObject <DDLogFormatter>

@property (nonatomic) int atomicLoggerCount;
@property (strong, nonatomic) NSDateFormatter *threadUnsafeDateFormatter;

/**
 Configures CocoaLumberjack.
 */
+ (void)configureLogging;

@end
