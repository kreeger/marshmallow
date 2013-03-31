// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKUser.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKUserAttributes {
	__unsafe_unretained NSString *admin;
	__unsafe_unretained NSString *avatarUrl;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *emailAddress;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *type;
} BDKUserAttributes;

extern const struct BDKUserRelationships {
} BDKUserRelationships;

extern const struct BDKUserFetchedProperties {
} BDKUserFetchedProperties;










@interface BDKUserID : NSManagedObjectID {}
@end

@interface _BDKUser : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKUserID*)objectID;





@property (nonatomic, strong) NSNumber* admin;



@property BOOL adminValue;
- (BOOL)adminValue;
- (void)setAdminValue:(BOOL)value_;

//- (BOOL)validateAdmin:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* avatarUrl;



//- (BOOL)validateAvatarUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* emailAddress;



//- (BOOL)validateEmailAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;






@end

@interface _BDKUser (CoreDataGeneratedAccessors)

@end

@interface _BDKUser (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAdmin;
- (void)setPrimitiveAdmin:(NSNumber*)value;

- (BOOL)primitiveAdminValue;
- (void)setPrimitiveAdminValue:(BOOL)value_;




- (NSString*)primitiveAvatarUrl;
- (void)setPrimitiveAvatarUrl:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSString*)primitiveEmailAddress;
- (void)setPrimitiveEmailAddress:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




@end
