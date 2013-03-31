// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKAccount.m instead.

#import "_BDKAccount.h"

const struct BDKAccountAttributes BDKAccountAttributes = {
	.createdAt = @"createdAt",
	.identifier = @"identifier",
	.name = @"name",
	.ownerIdentifier = @"ownerIdentifier",
	.plan = @"plan",
	.storage = @"storage",
	.subdomain = @"subdomain",
	.timeZone = @"timeZone",
	.updatedAt = @"updatedAt",
};

const struct BDKAccountRelationships BDKAccountRelationships = {
};

const struct BDKAccountFetchedProperties BDKAccountFetchedProperties = {
};

@implementation BDKAccountID
@end

@implementation _BDKAccount

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKAccount" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKAccount";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKAccount" inManagedObjectContext:moc_];
}

- (BDKAccountID*)objectID {
	return (BDKAccountID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ownerIdentifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ownerIdentifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"storageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"storage"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic createdAt;






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






@dynamic ownerIdentifier;



- (int32_t)ownerIdentifierValue {
	NSNumber *result = [self ownerIdentifier];
	return [result intValue];
}

- (void)setOwnerIdentifierValue:(int32_t)value_ {
	[self setOwnerIdentifier:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOwnerIdentifierValue {
	NSNumber *result = [self primitiveOwnerIdentifier];
	return [result intValue];
}

- (void)setPrimitiveOwnerIdentifierValue:(int32_t)value_ {
	[self setPrimitiveOwnerIdentifier:[NSNumber numberWithInt:value_]];
}





@dynamic plan;






@dynamic storage;



- (int64_t)storageValue {
	NSNumber *result = [self storage];
	return [result longLongValue];
}

- (void)setStorageValue:(int64_t)value_ {
	[self setStorage:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveStorageValue {
	NSNumber *result = [self primitiveStorage];
	return [result longLongValue];
}

- (void)setPrimitiveStorageValue:(int64_t)value_ {
	[self setPrimitiveStorage:[NSNumber numberWithLongLong:value_]];
}





@dynamic subdomain;






@dynamic timeZone;






@dynamic updatedAt;











@end
