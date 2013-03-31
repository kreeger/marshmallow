// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKUpload.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKUploadAttributes {
	__unsafe_unretained NSString *byteSize;
	__unsafe_unretained NSString *contentType;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *fullUrl;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *roomIdentifier;
	__unsafe_unretained NSString *userIdentifier;
} BDKUploadAttributes;

extern const struct BDKUploadRelationships {
} BDKUploadRelationships;

extern const struct BDKUploadFetchedProperties {
} BDKUploadFetchedProperties;











@interface BDKUploadID : NSManagedObjectID {}
@end

@interface _BDKUpload : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKUploadID*)objectID;





@property (nonatomic, strong) NSNumber* byteSize;



@property int64_t byteSizeValue;
- (int64_t)byteSizeValue;
- (void)setByteSizeValue:(int64_t)value_;

//- (BOOL)validateByteSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* contentType;



//- (BOOL)validateContentType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fullUrl;



//- (BOOL)validateFullUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* roomIdentifier;



@property int32_t roomIdentifierValue;
- (int32_t)roomIdentifierValue;
- (void)setRoomIdentifierValue:(int32_t)value_;

//- (BOOL)validateRoomIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userIdentifier;



@property int32_t userIdentifierValue;
- (int32_t)userIdentifierValue;
- (void)setUserIdentifierValue:(int32_t)value_;

//- (BOOL)validateUserIdentifier:(id*)value_ error:(NSError**)error_;






@end

@interface _BDKUpload (CoreDataGeneratedAccessors)

@end

@interface _BDKUpload (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveByteSize;
- (void)setPrimitiveByteSize:(NSNumber*)value;

- (int64_t)primitiveByteSizeValue;
- (void)setPrimitiveByteSizeValue:(int64_t)value_;




- (NSString*)primitiveContentType;
- (void)setPrimitiveContentType:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSString*)primitiveFullUrl;
- (void)setPrimitiveFullUrl:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRoomIdentifier;
- (void)setPrimitiveRoomIdentifier:(NSNumber*)value;

- (int32_t)primitiveRoomIdentifierValue;
- (void)setPrimitiveRoomIdentifierValue:(int32_t)value_;




- (NSNumber*)primitiveUserIdentifier;
- (void)setPrimitiveUserIdentifier:(NSNumber*)value;

- (int32_t)primitiveUserIdentifierValue;
- (void)setPrimitiveUserIdentifierValue:(int32_t)value_;




@end
