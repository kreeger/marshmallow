#import "BDKCFModel.h"

typedef enum {
    BDKCFMessageTypeText = 0,
    BDKCFMessageTypePaste,
    BDKCFMessageTypeSound,
    BDKCFMessageTypeAdvertisement,
    BDKCFMessageTypeAllowGuests,
    BDKCFMessageTypeDisallowGuests,
    BDKCFMessageTypeIdle,
    BDKCFMessageTypeKick,
    BDKCFMessageTypeLeave,
    BDKCFMessageTypeEnter,
    BDKCFMessageTypeSystem,
    BDKCFMessageTypeTimestamp,
    BDKCFMessageTypeTopicChange,
    BDKCFMessageTypeUnidle,
    BDKCFMessageTypeLock,
    BDKCFMessageTypeUnlock,
    BDKCFMessageTypeUpload,
    BDKCFMessageTypeConferenceCreated,
    BDKCFMessageTypeConferenceFinished,
    BDKCFMessageTypeUnknown,
    
} BDKCFMessageType;

@interface BDKCFMessage : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSNumber *roomIdentifier;
@property (strong, nonatomic) NSNumber *userIdentifier;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSDate *createdAt;
@property (nonatomic) BDKCFMessageType type;
@property (nonatomic) BOOL starred;

@property (readonly) NSDictionary *asApiBody;

+ (NSDictionary *)messageTypeMappings;
+ (id)messageWithBody:(NSString *)body type:(BDKCFMessageType)type;
- (id)initWithBody:(NSString *)body type:(BDKCFMessageType)type;

@end
