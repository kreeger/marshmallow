#import "BDKCFModel.h"

/** The 37signals Launchpad API uses these identity objects to identify a user across multiple services.
 */
@interface BDKLPIdentity : BDKCFModel

/** The 37signals Launchpad API identity model identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The email address of the user on the identity.
 */
@property (strong, nonatomic) NSString *emailAddress;

/** The identity user's first name.
 */
@property (strong, nonatomic) NSString *firstName;

/** The identity user's last name.
 */
@property (strong, nonatomic) NSString *lastName;

@end
