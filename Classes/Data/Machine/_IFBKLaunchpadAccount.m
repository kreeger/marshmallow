// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKLaunchpadAccount.m instead.

#import "_IFBKLaunchpadAccount.h"

const struct IFBKLaunchpadAccountAttributes IFBKLaunchpadAccountAttributes = {
	.href = @"href",
	.identifier = @"identifier",
	.name = @"name",
	.product = @"product",
};

const struct IFBKLaunchpadAccountRelationships IFBKLaunchpadAccountRelationships = {
	.campfireAccount = @"campfireAccount",
	.user = @"user",
};

const struct IFBKLaunchpadAccountFetchedProperties IFBKLaunchpadAccountFetchedProperties = {
};

@implementation IFBKLaunchpadAccountID
@end

@implementation _IFBKLaunchpadAccount

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IFBKLaunchpadAccount" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IFBKLaunchpadAccount";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IFBKLaunchpadAccount" inManagedObjectContext:moc_];
}

- (IFBKLaunchpadAccountID*)objectID {
	return (IFBKLaunchpadAccountID*)[super objectID];
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




@dynamic href;






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






@dynamic product;






@dynamic campfireAccount;

	

@dynamic user;

	






@end
