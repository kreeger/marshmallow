#import "BDKCFMessage.h"

#import <ISO8601DateFormatter/ISO8601DateFormatter.h>

@implementation BDKCFMessage

+ (NSDictionary *)apiMappingHash
{
    return @{@"id": @"identifier",
             @"room_id": @"roomIdentifier",
             @"user_id": @"userIdentifier",
             @"body": @"body"};
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;
        
        if ([dictionary[@"product"] isEqualToString:@"TextMessage"]) _type = BDKCFMessageTypeText;
        else if ([dictionary[@"product"] isEqualToString:@"PasteMessage"]) _type = BDKCFMessageTypePaste;
        else if ([dictionary[@"product"] isEqualToString:@"SoundMessage"]) _type = BDKCFMessageTypeSound;
        else if ([dictionary[@"product"] isEqualToString:@"AdvertisementMessage"]) _type = BDKCFMessageTypeAdvertisement;
        else if ([dictionary[@"product"] isEqualToString:@"AllowGuestsMessage"]) _type = BDKCFMessageTypeAllowGuests;
        else if ([dictionary[@"product"] isEqualToString:@"DisallowGuestsMessage"]) _type = BDKCFMessageTypeDisallowGuests;
        else if ([dictionary[@"product"] isEqualToString:@"IdleMessage"]) _type = BDKCFMessageTypeIdle;
        else if ([dictionary[@"product"] isEqualToString:@"KickMessage"]) _type = BDKCFMessageTypeKick;
        else if ([dictionary[@"product"] isEqualToString:@"LeaveMessage"]) _type = BDKCFMessageTypeLeave;
        else if ([dictionary[@"product"] isEqualToString:@"EnterMessage"]) _type = BDKCFMessageTypeEnter;
        else if ([dictionary[@"product"] isEqualToString:@"SystemMessage"]) _type = BDKCFMessageTypeSystem;
        else if ([dictionary[@"product"] isEqualToString:@"TimestampMessage"]) _type = BDKCFMessageTypeTimestamp;
        else if ([dictionary[@"product"] isEqualToString:@"TopicChangeMessage"]) _type = BDKCFMessageTypeTopicChange;
        else if ([dictionary[@"product"] isEqualToString:@"UnidleMessage"]) _type = BDKCFMessageTypeUnidle;
        else if ([dictionary[@"product"] isEqualToString:@"LockMessage"]) _type = BDKCFMessageTypeLock;
        else if ([dictionary[@"product"] isEqualToString:@"UnlockMessage"]) _type = BDKCFMessageTypeUnlock;
        else if ([dictionary[@"product"] isEqualToString:@"UploadMessage"]) _type = BDKCFMessageTypeUpload;
        else if ([dictionary[@"product"] isEqualToString:@"ConferenceCreatedMessage"]) _type = BDKCFMessageTypeConferenceCreated;
        else if ([dictionary[@"product"] isEqualToString:@"ConferenceFinishedMessage"]) _type = BDKCFMessageTypeConferenceFinished;
        else _type = BDKCFMessageTypeUnknown;
        
        _starred = [dictionary[@"starred"] isEqualToString:@"true"];
    }

    return self;
}

@end
