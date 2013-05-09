// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKUser.m instead.

#import "_IFBKUser.h"

const struct IFBKUserAttributes IFBKUserAttributes = {
	.admin = @"admin",
	.apiAuthToken = @"apiAuthToken",
	.avatarUrl = @"avatarUrl",
	.createdAt = @"createdAt",
	.emailAddress = @"emailAddress",
	.identifier = @"identifier",
	.name = @"name",
	.type = @"type",
};

const struct IFBKUserRelationships IFBKUserRelationships = {
	.launchpadAccount = @"launchpadAccount",
};

const struct IFBKUserFetchedProperties IFBKUserFetchedProperties = {
};

@implementation IFBKUserID
@end

@implementation _IFBKUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IFBKUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IFBKUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IFBKUser" inManagedObjectContext:moc_];
}

- (IFBKUserID*)objectID {
	return (IFBKUserID*)[super objectID];
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





@dynamic apiAuthToken;






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






@dynamic launchpadAccount;

	






@end
