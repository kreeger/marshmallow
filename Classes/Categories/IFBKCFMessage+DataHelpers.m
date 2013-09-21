#import "IFBKCFMessage+DataHelpers.h"
#import "MLLWCoreDataStore.h"
#import "MLLWUser.h"
#import "MLLWManagedObject.h"

@implementation IFBKCFMessage (DataHelpers)

- (MLLWUser *)user {
    return [MLLWUser findByIdentifier:self.userIdentifier inContext:[NSManagedObjectContext defaultContext]];
}

@end
