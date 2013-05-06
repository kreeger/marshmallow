// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKIdentity.h instead.

#import <CoreData/CoreData.h>
#import "IFBKModel.h"

extern const struct IFBKIdentityAttributes {
	__unsafe_unretained NSString *emailAddress;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *lastName;
} IFBKIdentityAttributes;

extern const struct IFBKIdentityRelationships {
} IFBKIdentityRelationships;

extern const struct IFBKIdentityFetchedProperties {
} IFBKIdentityFetchedProperties;







@interface IFBKIdentityID : NSManagedObjectID {}
@end

@interface _IFBKIdentity : IFBKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IFBKIdentityID*)objectID;





@property (nonatomic, strong) NSString* emailAddress;



//- (BOOL)validateEmailAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;






@end

@interface _IFBKIdentity (CoreDataGeneratedAccessors)

@end

@interface _IFBKIdentity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmailAddress;
- (void)setPrimitiveEmailAddress:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




@end
