#import "IFBKCFMessage+DataHelpers.h"
#import "IFBKCoreDataStore.h"
#import "IFBKUser.h"
#import "IFBKManagedObject+Finders.h"

@implementation IFBKCFMessage (DataHelpers)

- (IFBKUser *)user {
    return [IFBKUser findByIdentifier:self.userIdentifier inContext:[NSManagedObjectContext defaultContext]];
}

@end
