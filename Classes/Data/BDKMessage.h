#import "_BDKMessage.h"

typedef enum {
    BDKMessageTypeText = 0,
    BDKMessageTypePaste,
    BDKMessageTypeSound,
    BDKMessageTypeAdvertisement,
    BDKMessageTypeAllowGuests,
    BDKMessageTypeDisallowGuests,
    BDKMessageTypeIdle,
    BDKMessageTypeKick,
    BDKMessageTypeLeave,
    BDKMessageTypeEnter,
    BDKMessageTypeSystem,
    BDKMessageTypeTimestamp,
    BDKMessageTypeTopicChange,
    BDKMessageTypeUnidle,
    BDKMessageTypeLock,
    BDKMessageTypeUnlock,
    BDKMessageTypeUpload,
    BDKMessageTypeConferenceCreated,
    BDKMessageTypeConferenceFinished,
    BDKMessageTypeUnknown,

} BDKMessageType;

/** A Core Data representation of a Campfire message.
 */
@interface BDKMessage : _BDKMessage {}

/** The type of message that was posted; could be a standard BDKMessageTypeText, a BDKMessageTypePaste, or so on.
 */
@property (readonly) BDKMessageType messageType;

/** A dictionary representation of internal BDKCFMessageType names to the text names that come from the Campfire API.
 */
+ (NSDictionary *)messageTypeMappings;

@end
