// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BDKUpload.m instead.

#import "_BDKUpload.h"

const struct BDKUploadAttributes BDKUploadAttributes = {
	.byteSize = @"byteSize",
	.contentType = @"contentType",
	.createdAt = @"createdAt",
	.fullUrl = @"fullUrl",
	.identifier = @"identifier",
	.name = @"name",
	.roomIdentifier = @"roomIdentifier",
	.userIdentifier = @"userIdentifier",
};

const struct BDKUploadRelationships BDKUploadRelationships = {
};

const struct BDKUploadFetchedProperties BDKUploadFetchedProperties = {
};

@implementation BDKUploadID
@end

@implementation _BDKUpload

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BDKUpload" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BDKUpload";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BDKUpload" inManagedObjectContext:moc_];
}

- (BDKUploadID*)objectID {
	return (BDKUploadID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"byteSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"byteSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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
	if ([key isEqualToString:@"userIdentifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userIdentifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic byteSize;



- (int64_t)byteSizeValue {
	NSNumber *result = [self byteSize];
	return [result longLongValue];
}

- (void)setByteSizeValue:(int64_t)value_ {
	[self setByteSize:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveByteSizeValue {
	NSNumber *result = [self primitiveByteSize];
	return [result longLongValue];
}

- (void)setPrimitiveByteSizeValue:(int64_t)value_ {
	[self setPrimitiveByteSize:[NSNumber numberWithLongLong:value_]];
}





@dynamic contentType;






@dynamic createdAt;






@dynamic fullUrl;






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
