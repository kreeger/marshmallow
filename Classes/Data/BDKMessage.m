#import "BDKMessage.h"
#import "BDKCFMessage.h"

@implementation BDKMessage

@dynamic messageType;

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKCFMessage *message = (BDKCFMessage *)model;
    NSArray *attributes = @[@"identifier", @"roomIdentifier", @"userIdentifier", @"body", @"createdAt", @"type",
                            @"starred"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[message valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

+ (NSDictionary *)messageTypeMappings
{
    return @{@"TextMessage": @(BDKMessageTypeText),
             @"PasteMessage": @(BDKMessageTypePaste),
             @"SoundMessage": @(BDKMessageTypeSound),
             @"AdvertisementMessage": @(BDKMessageTypeAdvertisement),
             @"AllowGuestsMessage": @(BDKMessageTypeAllowGuests),
             @"DisallowGuestsMessage": @(BDKMessageTypeDisallowGuests),
             @"IdleMessage": @(BDKMessageTypeIdle),
             @"KickMessage": @(BDKMessageTypeKick),
             @"LeaveMessage": @(BDKMessageTypeLeave),
             @"EnterMessage": @(BDKMessageTypeEnter),
             @"SystemMessage": @(BDKMessageTypeSystem),
             @"TimestampMessage": @(BDKMessageTypeTimestamp),
             @"TopicChangeMessage": @(BDKMessageTypeTopicChange),
             @"UnidleMessage": @(BDKMessageTypeUnidle),
             @"LockMessage": @(BDKMessageTypeLock),
             @"UnlockMessage": @(BDKMessageTypeUnlock),
             @"UploadMessage": @(BDKMessageTypeUpload),
             @"ConferenceCreatedMessage": @(BDKMessageTypeConferenceCreated),
             @"ConferenceFinishedMessage": @(BDKMessageTypeConferenceFinished)};
}

- (BDKMessageType)messageType
{
    NSNumber *type = [[self class] messageTypeMappings][self.type];
    return type ? type.integerValue : BDKMessageTypeUnknown;
}

@end
