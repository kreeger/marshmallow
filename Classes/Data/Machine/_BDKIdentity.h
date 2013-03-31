// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKIdentity.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKIdentityAttributes {
	__unsafe_unretained NSString *emailAddress;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *lastName;
} BDKIdentityAttributes;

extern const struct BDKIdentityRelationships {
} BDKIdentityRelationships;

extern const struct BDKIdentityFetchedProperties {
} BDKIdentityFetchedProperties;







@interface BDKIdentityID : NSManagedObjectID {}
@end

@interface _BDKIdentity : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKIdentityID*)objectID;





@property (nonatomic, strong) NSString* emailAddress;



//- (BOOL)validateEmailAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int32_t identifierValue;
- (int32_t)identifierValue;
- (void)setIdentifierValue:(int32_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* lastName;



@property int32_t lastNameValue;
- (int32_t)lastNameValue;
- (void)setLastNameValue:(int32_t)value_;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;






@end

@interface _BDKIdentity (CoreDataGeneratedAccessors)

@end

@interface _BDKIdentity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmailAddress;
- (void)setPrimitiveEmailAddress:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSNumber*)primitiveLastName;
- (void)setPrimitiveLastName:(NSNumber*)value;

- (int32_t)primitiveLastNameValue;
- (void)setPrimitiveLastNameValue:(int32_t)value_;




@end
