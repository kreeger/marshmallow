// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKUser.m instead.

#import "_BDKUser.h"

const struct BDKUserAttributes BDKUserAttributes = {
	.admin = @"admin",
	.avatarUrl = @"avatarUrl",
	.createdAt = @"createdAt",
	.emailAddress = @"emailAddress",
	.identifier = @"identifier",
	.name = @"name",
	.type = @"type",
};

const struct BDKUserRelationships BDKUserRelationships = {
};

const struct BDKUserFetchedProperties BDKUserFetchedProperties = {
};

@implementation BDKUserID
@end

@implementation _BDKUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKUser" inManagedObjectContext:moc_];
}

- (BDKUserID*)objectID {
	return (BDKUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"adminValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"admin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic admin;



- (BOOL)adminValue {
	NSNumber *result = [self admin];
	return [result boolValue];
}

- (void)setAdminValue:(BOOL)value_ {
	[self setAdmin:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAdminValue {
	NSNumber *result = [self primitiveAdmin];
	return [result boolValue];
}

- (void)setPrimitiveAdminValue:(BOOL)value_ {
	[self setPrimitiveAdmin:[NSNumber numberWithBool:value_]];
}





@dynamic avatarUrl;






@dynamic createdAt;






@dynamic emailAddress;






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





@dynamic name;






@dynamic type;











@end
