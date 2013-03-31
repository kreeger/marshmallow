// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKIdentity.m instead.

#import "_BDKIdentity.h"

const struct BDKIdentityAttributes BDKIdentityAttributes = {
	.emailAddress = @"emailAddress",
	.firstName = @"firstName",
	.identifier = @"identifier",
	.lastName = @"lastName",
};

const struct BDKIdentityRelationships BDKIdentityRelationships = {
};

const struct BDKIdentityFetchedProperties BDKIdentityFetchedProperties = {
};

@implementation BDKIdentityID
@end

@implementation _BDKIdentity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKIdentity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKIdentity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKIdentity" inManagedObjectContext:moc_];
}

- (BDKIdentityID*)objectID {
	return (BDKIdentityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lastNameValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lastName"];
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



- (int32_t)lastNameValue {
	NSNumber *result = [self lastName];
	return [result intValue];
}

- (void)setLastNameValue:(int32_t)value_ {
	[self setLastName:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveLastNameValue {
	NSNumber *result = [self primitiveLastName];
	return [result intValue];
}

- (void)setPrimitiveLastNameValue:(int32_t)value_ {
	[self setPrimitiveLastName:[NSNumber numberWithInt:value_]];
}










@end
