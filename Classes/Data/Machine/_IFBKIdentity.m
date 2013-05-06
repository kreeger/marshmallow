// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKIdentity.m instead.

#import "_IFBKIdentity.h"

const struct IFBKIdentityAttributes IFBKIdentityAttributes = {
	.emailAddress = @"emailAddress",
	.firstName = @"firstName",
	.identifier = @"identifier",
	.lastName = @"lastName",
};

const struct IFBKIdentityRelationships IFBKIdentityRelationships = {
};

const struct IFBKIdentityFetchedProperties IFBKIdentityFetchedProperties = {
};

@implementation IFBKIdentityID
@end

@implementation _IFBKIdentity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IFBKIdentity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IFBKIdentity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IFBKIdentity" inManagedObjectContext:moc_];
}

- (IFBKIdentityID*)objectID {
	return (IFBKIdentityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic emailAddress;






@dynamic firstName;






@dynamic identifier;



- (int32_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result intValue];
}

- (void)setIdentifierValue:(int32_t)value_ {
	[self setIdentifier:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveIdentifierValue {
	NSNumber *result = [self primitiveIdentifier];
	return [result intValue];
}

- (void)setPrimitiveIdentifierValue:(int32_t)value_ {
	[self setPrimitiveIdentifier:[NSNumber numberWithInt:value_]];
}





@dynamic lastName;











@end
