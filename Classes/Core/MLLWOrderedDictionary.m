#import "MLLWOrderedDictionary.h"

@interface MLLWOrderedDictionary ()

/**
 The internal dictionary this class wraps.
 */
@property (strong, nonatomic) NSMutableDictionary *dictionary;

/**
 The internal ordered array in which this class stores its key ordering.
 */
@property (strong, nonatomic) NSMutableArray *array;

@end

NSString *DescriptionForObject(NSObject *object, id locale, NSUInteger indent) {
	NSString *objectString;

	if ([object isKindOfClass:[NSString class]]) {
		objectString = (NSString *)object;
	} else if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
		objectString = [(NSDictionary *)object descriptionWithLocale:locale indent:indent];
	} else if ([object respondsToSelector:@selector(descriptionWithLocale:)]) {
		objectString = [(NSSet *)object descriptionWithLocale:locale];
	} else {
        objectString = [object description];
    }

	return objectString;
}

@implementation MLLWOrderedDictionary

- (instancetype)init {
	return [self initWithCapacity:0];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (!self) return nil;
    _dictionary = [NSMutableDictionary dictionaryWithCapacity:capacity];
    _array = [NSMutableArray arrayWithCapacity:capacity];
	return self;
}

- (instancetype)copy {
	return [self mutableCopy];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    if (aKey == nil) return;
	if (![self.dictionary objectForKey:aKey]) {
        [self.array addObject:aKey];
    }
    
	[self.dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey {
	[self.dictionary removeObjectForKey:aKey];
	[self.array removeObject:aKey];
}

- (NSUInteger)count {
	return [self.dictionary count];
}

- (id)objectForKey:(id)aKey {
	return [self.dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator {
	return [self.array objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator {
	return [self.array reverseObjectEnumerator];
}

- (NSArray *)sortedKeys {
    return [[self allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex {
	if ([self.dictionary objectForKey:aKey]) {
        [self removeObjectForKey:aKey];
    }
    
	[self.array insertObject:aKey atIndex:anIndex];
	[self.dictionary setObject:anObject forKey:aKey];
}

- (id)keyAtIndex:(NSUInteger)anIndex {
	return [self.array objectAtIndex:anIndex];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
	NSMutableString *indentString = [NSMutableString string];
	NSUInteger i, count = level;
	for (i = 0; i < count; i++) {
        [indentString appendFormat:@"    "];
    }

	NSMutableString *description = [NSMutableString string];
	[description appendFormat:@"%@{\n", indentString];
	for (NSObject *key in self) {
		[description appendFormat:@"%@    %@ = %@;\n",
         indentString,
         DescriptionForObject(key, locale, level),
         DescriptionForObject([self objectForKey:key], locale, level)];
	}

	[description appendFormat:@"%@}\n", indentString];
	return description;
}


@end
