// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKLaunchpadAccount.h instead.

#import <CoreData/CoreData.h>
#import "BDKModel.h"

extern const struct BDKLaunchpadAccountAttributes {
	__unsafe_unretained NSString *hrefUrl;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *type;
} BDKLaunchpadAccountAttributes;

extern const struct BDKLaunchpadAccountRelationships {
} BDKLaunchpadAccountRelationships;

extern const struct BDKLaunchpadAccountFetchedProperties {
} BDKLaunchpadAccountFetchedProperties;







@interface BDKLaunchpadAccountID : NSManagedObjectID {}
@end

@interface _BDKLaunchpadAccount : BDKModel {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BDKLaunchpadAccountID*)objectID;





@property (nonatomic, strong) NSString* hrefUrl;



//- (BOOL)validateHrefUrl:(id*)value_ error:(NSError**)error_;





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

@interface _BDKLaunchpadAccount (CoreDataGeneratedAccessors)

@end

@interface _BDKLaunchpadAccount (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveHrefUrl;
- (void)setPrimitiveHrefUrl:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int32_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




@end
