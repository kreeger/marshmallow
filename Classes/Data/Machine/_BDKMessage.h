// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKMessage.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKMessageAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *roomIdentifier;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *userIdentifier;
} BDKMessageAttributes;

extern const struct BDKMessageRelationships {
} BDKMessageRelationships;

extern const struct BDKMessageFetchedProperties {
} BDKMessageFetchedProperties;









@interface BDKMessageID : NSManagedObjectID {}
@end

@interface _BDKMessage : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKMessageID*)objectID;





@property (nonatomic, strong) NSString* body;



//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* roomIdentifier;



@property int32_t roomIdentifierValue;
- (int32_t)roomIdentifierValue;
- (void)setRoomIdentifierValue:(int32_t)value_;

//- (BOOL)validateRoomIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userIdentifier;



@property int32_t userIdentifierValue;
- (int32_t)userIdentifierValue;
- (void)setUserIdentifierValue:(int32_t)value_;

//- (BOOL)validateUserIdentifier:(id*)value_ error:(NSError**)error_;






@end

@interface _BDKMessage (CoreDataGeneratedAccessors)

@end

@interface _BDKMessage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSNumber*)primitiveRoomIdentifier;
- (void)setPrimitiveRoomIdentifier:(NSNumber*)value;

- (int32_t)primitiveRoomIdentifierValue;
- (void)setPrimitiveRoomIdentifierValue:(int32_t)value_;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSNumber*)primitiveUserIdentifier;
- (void)setPrimitiveUserIdentifier:(NSNumber*)value;

- (int32_t)primitiveUserIdentifierValue;
- (void)setPrimitiveUserIdentifierValue:(int32_t)value_;




@end
