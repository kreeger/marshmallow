// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKMessage.m instead.

#import "_BDKMessage.h"

const struct BDKMessageAttributes BDKMessageAttributes = {
	.body = @"body",
	.createdAt = @"createdAt",
	.identifier = @"identifier",
	.roomIdentifier = @"roomIdentifier",
	.starred = @"starred",
	.type = @"type",
	.userIdentifier = @"userIdentifier",
};

const struct BDKMessageRelationships BDKMessageRelationships = {
};

const struct BDKMessageFetchedProperties BDKMessageFetchedProperties = {
};

@implementation BDKMessageID
@end

@implementation _BDKMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKMessage" inManagedObjectContext:moc_];
}

- (BDKMessageID*)objectID {
	return (BDKMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"roomIdentifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"roomIdentifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"starredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"starred"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"userIdentifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userIdentifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic body;






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





@dynamic roomIdentifier;



- (int32_t)roomIdentifierValue {
	NSNumber *result = [self roomIdentifier];
	return [result intValue];
}

- (void)setRoomIdentifierValue:(int32_t)value_ {
	[self setRoomIdentifier:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRoomIdentifierValue {
	NSNumber *result = [self primitiveRoomIdentifier];
	return [result intValue];
}

- (void)setPrimitiveRoomIdentifierValue:(int32_t)value_ {
	[self setPrimitiveRoomIdentifier:[NSNumber numberWithInt:value_]];
}





@dynamic starred;



- (BOOL)starredValue {
	NSNumber *result = [self starred];
	return [result boolValue];
}

- (void)setStarredValue:(BOOL)value_ {
	[self setStarred:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveStarredValue {
	NSNumber *result = [self primitiveStarred];
	return [result boolValue];
}

- (void)setPrimitiveStarredValue:(BOOL)value_ {
	[self setPrimitiveStarred:[NSNumber numberWithBool:value_]];
}





@dynamic type;






@dynamic userIdentifier;



- (int32_t)userIdentifierValue {
	NSNumber *result = [self userIdentifier];
	return [result intValue];
}

- (void)setUserIdentifierValue:(int32_t)value_ {
	[self setUserIdentifier:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUserIdentifierValue {
	NSNumber *result = [self primitiveUserIdentifier];
	return [result intValue];
}

- (void)setPrimitiveUserIdentifierValue:(int32_t)value_ {
	[self setPrimitiveUserIdentifier:[NSNumber numberWithInt:value_]];
}










@end
