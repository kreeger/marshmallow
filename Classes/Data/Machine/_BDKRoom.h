// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKRoom.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKRoomAttributes {
	__unsafe_unretained NSString *activeTokenValue;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *full;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *membershipLimit;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *openToGuests;
	__unsafe_unretained NSString *topic;
	__unsafe_unretained NSString *updatedAt;
} BDKRoomAttributes;

extern const struct BDKRoomRelationships {
	__unsafe_unretained NSString *account;
} BDKRoomRelationships;

extern const struct BDKRoomFetchedProperties {
} BDKRoomFetchedProperties;

@class BDKAccount;











@interface BDKRoomID : NSManagedObjectID {}
@end

@interface _BDKRoom : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKRoomID*)objectID;





@property (nonatomic, strong) NSString* activeTokenValue;



//- (BOOL)validateActiveTokenValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* full;



@property BOOL fullValue;
- (BOOL)fullValue;
- (void)setFullValue:(BOOL)value_;

//- (BOOL)validateFull:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* membershipLimit;



@property int16_t membershipLimitValue;
- (int16_t)membershipLimitValue;
- (void)setMembershipLimitValue:(int16_t)value_;

//- (BOOL)validateMembershipLimit:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* openToGuests;



@property BOOL openToGuestsValue;
- (BOOL)openToGuestsValue;
- (void)setOpenToGuestsValue:(BOOL)value_;

//- (BOOL)validateOpenToGuests:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* topic;



//- (BOOL)validateTopic:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updatedAt;



//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) BDKAccount *account;

//- (BOOL)validateAccount:(id*)value_ error:(NSError**)error_;





@end

@interface _BDKRoom (CoreDataGeneratedAccessors)

@end

@interface _BDKRoom (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActiveTokenValue;
- (void)setPrimitiveActiveTokenValue:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSNumber*)primitiveFull;
- (void)setPrimitiveFull:(NSNumber*)value;

- (BOOL)primitiveFullValue;
- (void)setPrimitiveFullValue:(BOOL)value_;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSNumber*)primitiveMembershipLimit;
- (void)setPrimitiveMembershipLimit:(NSNumber*)value;

- (int16_t)primitiveMembershipLimitValue;
- (void)setPrimitiveMembershipLimitValue:(int16_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveOpenToGuests;
- (void)setPrimitiveOpenToGuests:(NSNumber*)value;

- (BOOL)primitiveOpenToGuestsValue;
- (void)setPrimitiveOpenToGuestsValue:(BOOL)value_;




- (NSString*)primitiveTopic;
- (void)setPrimitiveTopic:(NSString*)value;




- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;





- (BDKAccount*)primitiveAccount;
- (void)setPrimitiveAccount:(BDKAccount*)value;


@end
