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

+ (NSDictionary *)messageTypeMappings
{
    return @{@"TextMessage": @(BDKCFMessageTypeText),
             @"PasteMessage": @(BDKCFMessageTypePaste),
             @"SoundMessage": @(BDKCFMessageTypeSound),
             @"AdvertisementMessage": @(BDKCFMessageTypeAdvertisement),
             @"AllowGuestsMessage": @(BDKCFMessageTypeAllowGuests),
             @"DisallowGuestsMessage": @(BDKCFMessageTypeDisallowGuests),
             @"IdleMessage": @(BDKCFMessageTypeIdle),
             @"KickMessage": @(BDKCFMessageTypeKick),
             @"LeaveMessage": @(BDKCFMessageTypeLeave),
             @"EnterMessage": @(BDKCFMessageTypeEnter),
             @"SystemMessage": @(BDKCFMessageTypeSystem),
             @"TimestampMessage": @(BDKCFMessageTypeTimestamp),
             @"TopicChangeMessage": @(BDKCFMessageTypeTopicChange),
             @"UnidleMessage": @(BDKCFMessageTypeUnidle),
             @"LockMessage": @(BDKCFMessageTypeLock),
             @"UnlockMessage": @(BDKCFMessageTypeUnlock),
             @"UploadMessage": @(BDKCFMessageTypeUpload),
             @"ConferenceCreatedMessage": @(BDKCFMessageTypeConferenceCreated),
             @"ConferenceFinishedMessage": @(BDKCFMessageTypeConferenceFinished)};
}

+ (id)messageWithBody:(NSString *)body type:(BDKCFMessageType)type
{
    return [[self alloc] initWithBody:body type:type];
}

- (id)initWithBody:(NSString *)body type:(BDKCFMessageType)type
{
    if (self = [super init]) {
        _body = body;
        _type = type;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super initWithDictionary:dictionary])) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        _createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        formatter = nil;

        _type = [[[self class] messageTypeMappings][dictionary[@"product"]] integerValue];
        unless (_type) _type = BDKCFMessageTypeUnknown;

        _starred = [dictionary[@"starred"] isEqualToString:@"true"];
    }

    return self;
}

#pragma mark - Properties

- (NSDictionary *)asApiBody {
    // TODO: Convert line breaks to &#xA;
    return @{@"body": self.body,
             @"type": [[[[self class] messageTypeMappings] allKeysForObject:@(self.type)] first]};
}

@end
