// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKLaunchpadAccount.h instead.

#import <CoreData/CoreData.h>
#import "IFBKModel.h"

extern const struct IFBKLaunchpadAccountAttributes {
	__unsafe_unretained NSString *href;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *product;
} IFBKLaunchpadAccountAttributes;

extern const struct IFBKLaunchpadAccountRelationships {
	__unsafe_unretained NSString *campfireAccount;
	__unsafe_unretained NSString *user;
} IFBKLaunchpadAccountRelationships;

extern const struct IFBKLaunchpadAccountFetchedProperties {
} IFBKLaunchpadAccountFetchedProperties;

@class IFBKAccount;
@class IFBKUser;






@interface IFBKLaunchpadAccountID : NSManagedObjectID {}
@end

@interface _IFBKLaunchpadAccount : IFBKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IFBKLaunchpadAccountID*)objectID;





@property (nonatomic, strong) NSString* href;



//- (BOOL)validateHref:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* product;



//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) IFBKAccount *campfireAccount;

//- (BOOL)validateCampfireAccount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) IFBKUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _IFBKLaunchpadAccount (CoreDataGeneratedAccessors)

@end

@interface _IFBKLaunchpadAccount (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveHref;
- (void)setPrimitiveHref:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveProduct;
- (void)setPrimitiveProduct:(NSString*)value;





- (IFBKAccount*)primitiveCampfireAccount;
- (void)setPrimitiveCampfireAccount:(IFBKAccount*)value;



- (IFBKUser*)primitiveUser;
- (void)setPrimitiveUser:(IFBKUser*)value;


@end
