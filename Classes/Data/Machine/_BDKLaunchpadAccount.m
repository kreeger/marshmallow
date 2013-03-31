// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKLaunchpadAccount.m instead.

#import "_BDKLaunchpadAccount.h"

const struct BDKLaunchpadAccountAttributes BDKLaunchpadAccountAttributes = {
	.hrefUrl = @"hrefUrl",
	.identifier = @"identifier",
	.name = @"name",
	.type = @"type",
};

const struct BDKLaunchpadAccountRelationships BDKLaunchpadAccountRelationships = {
};

const struct BDKLaunchpadAccountFetchedProperties BDKLaunchpadAccountFetchedProperties = {
};

@implementation BDKLaunchpadAccountID
@end

@implementation _BDKLaunchpadAccount

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKLaunchpadAccount" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKLaunchpadAccount";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKLaunchpadAccount" inManagedObjectContext:moc_];
}

- (BDKLaunchpadAccountID*)objectID {
	return (BDKLaunchpadAccountID*)[super objectID];
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




@dynamic hrefUrl;






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
