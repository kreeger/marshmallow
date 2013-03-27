#import "BDKCFUpload.h"
#import "NSString+BDKKit.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

//<upload>
//<id type="integer">1</id>
//<name>picture.jpg</name>
//<room-id type="integer">1</room-id>
//<user-id type="integer">1</user-id>
//<byte-size type="integer">10063</byte-size>
//<content-type>image/jpeg</content-type>
//<full-url>https://account.campfirenow.com/room/1/uploads/1/picture.jpg</full-url>
//<created-at type="datetime">2009-11-20T23:25:14Z</created-at>
//</upload>

@implementation BDKCFUpload

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"name": @"name",
             @"room_id": @"roomIdentifer",
             @"user_id": @"userIdentifier",
             @"byte_size": @"byteSize",
             @"content_type": @"contentType"};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        _fullUrl = [dictionary[@"full_url"] urlValue];
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;
    }
    return self;
}

@end
