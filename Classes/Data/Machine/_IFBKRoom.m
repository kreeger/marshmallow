// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IFBKRoom.m instead.

#import "_IFBKRoom.h"

const struct IFBKRoomAttributes IFBKRoomAttributes = {
	.activeTokenValue = @"activeTokenValue",
	.createdAt = @"createdAt",
	.full = @"full",
	.identifier = @"identifier",
	.membershipLimit = @"membershipLimit",
	.name = @"name",
	.openToGuests = @"openToGuests",
	.topic = @"topic",
	.updatedAt = @"updatedAt",
};

const struct IFBKRoomRelationships IFBKRoomRelationships = {
};

const struct IFBKRoomFetchedProperties IFBKRoomFetchedProperties = {
};

@implementation IFBKRoomID
@end

@implementation _IFBKRoom

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IFBKRoom" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IFBKRoom";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IFBKRoom" inManagedObjectContext:moc_];
}

- (IFBKRoomID*)objectID {
	return (IFBKRoomID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"fullValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"full"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"membershipLimitValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"membershipLimit"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"openToGuestsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"openToGuests"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic activeTokenValue;






@dynamic createdAt;






@dynamic full;



- (BOOL)fullValue {
	NSNumber *result = [self full];
	return [result boolValue];
}

- (void)setFullValue:(BOOL)value_ {
	[self setFull:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFullValue {
	NSNumber *result = [self primitiveFull];
	return [result boolValue];
}

- (void)setPrimitiveFullValue:(BOOL)value_ {
	[self setPrimitiveFull:[NSNumber numberWithBool:value_]];
}





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





@dynamic membershipLimit;



- (int16_t)membershipLimitValue {
	NSNumber *result = [self membershipLimit];
	return [result shortValue];
}

- (void)setMembershipLimitValue:(int16_t)value_ {
	[self setMembershipLimit:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMembershipLimitValue {
	NSNumber *result = [self primitiveMembershipLimit];
	return [result shortValue];
}

- (void)setPrimitiveMembershipLimitValue:(int16_t)value_ {
	[self setPrimitiveMembershipLimit:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic openToGuests;



- (BOOL)openToGuestsValue {
	NSNumber *result = [self openToGuests];
	return [result boolValue];
}

- (void)setOpenToGuestsValue:(BOOL)value_ {
	[self setOpenToGuests:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveOpenToGuestsValue {
	NSNumber *result = [self primitiveOpenToGuests];
	return [result boolValue];
}

- (void)setPrimitiveOpenToGuestsValue:(BOOL)value_ {
	[self setPrimitiveOpenToGuests:[NSNumber numberWithBool:value_]];
}





@dynamic topic;






@dynamic updatedAt;











@end
