#import "NSDate+Marshmallow.h"

@implementation NSDate (Marshmallow)

+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *comps = [NSDateComponents new];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDate *)beginningOfDay {
    NSUInteger components = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components fromDate:self];
    return [NSDate dateFromYear:[dateComponents year] month:[dateComponents month] day:[dateComponents day]];
}

@end
