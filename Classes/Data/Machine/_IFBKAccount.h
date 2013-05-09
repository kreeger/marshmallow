// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKAccount.h instead.

#import <CoreData/CoreData.h>
#import "IFBKModel.h"

extern const struct IFBKAccountAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *ownerIdentifier;
	__unsafe_unretained NSString *plan;
	__unsafe_unretained NSString *storage;
	__unsafe_unretained NSString *subdomain;
	__unsafe_unretained NSString *timeZone;
	__unsafe_unretained NSString *updatedAt;
} IFBKAccountAttributes;

extern const struct IFBKAccountRelationships {
	__unsafe_unretained NSString *launchpadAccount;
} IFBKAccountRelationships;

extern const struct IFBKAccountFetchedProperties {
} IFBKAccountFetchedProperties;

@class IFBKLaunchpadAccount;











@interface IFBKAccountID : NSManagedObjectID {}
@end

@interface _IFBKAccount : IFBKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IFBKAccountID*)objectID;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* ownerIdentifier;



@property int32_t ownerIdentifierValue;
- (int32_t)ownerIdentifierValue;
- (void)setOwnerIdentifierValue:(int32_t)value_;

//- (BOOL)validateOwnerIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* plan;



//- (BOOL)validatePlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* storage;



@property int64_t storageValue;
- (int64_t)storageValue;
- (void)setStorageValue:(int64_t)value_;

//- (BOOL)validateStorage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* subdomain;



//- (BOOL)validateSubdomain:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* timeZone;



//- (BOOL)validateTimeZone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updatedAt;



//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) IFBKLaunchpadAccount *launchpadAccount;

//- (BOOL)validateLaunchpadAccount:(id*)value_ error:(NSError**)error_;





@end

@interface _IFBKAccount (CoreDataGeneratedAccessors)

@end

@interface _IFBKAccount (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveOwnerIdentifier;
- (void)setPrimitiveOwnerIdentifier:(NSNumber*)value;

- (int32_t)primitiveOwnerIdentifierValue;
- (void)setPrimitiveOwnerIdentifierValue:(int32_t)value_;




- (NSString*)primitivePlan;
- (void)setPrimitivePlan:(NSString*)value;




- (NSNumber*)primitiveStorage;
- (void)setPrimitiveStorage:(NSNumber*)value;

- (int64_t)primitiveStorageValue;
- (void)setPrimitiveStorageValue:(int64_t)value_;




- (NSString*)primitiveSubdomain;
- (void)setPrimitiveSubdomain:(NSString*)value;




- (NSString*)primitiveTimeZone;
- (void)setPrimitiveTimeZone:(NSString*)value;




- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;





- (IFBKLaunchpadAccount*)primitiveLaunchpadAccount;
- (void)setPrimitiveLaunchpadAccount:(IFBKLaunchpadAccount*)value;


@end
