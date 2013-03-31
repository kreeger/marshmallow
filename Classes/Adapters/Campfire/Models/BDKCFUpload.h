#import "BDKCFModel.h"

/** An internal representation of an uploaded file to a Campfire room.
 */
@interface BDKCFUpload : BDKCFModel

/** The 37signals Campfire API file upload identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The filename of the uploaded file.
 */
@property (strong, nonatomic) NSString *name;

/** The 37signals Campfire API room identifier where the file resides.
 */
@property (strong, nonatomic) NSNumber *roomIdentifier;

/** The 37signals Campfire API user identifier of the file uploader.
 */
@property (strong, nonatomic) NSNumber *userIdentifier;

/** The file size of the uploaded file.
 */
@property (strong, nonatomic) NSNumber *byteSize;

/** The mime type of the uploaded file.
 */
@property (strong, nonatomic) NSString *contentType;

/** The full URL where the file resides and can be retrieved.
 */
@property (strong, nonatomic) NSString *fullUrl;

/** The date and time when the file was uploaded.
 */
@property (strong, nonatomic) NSDate *createdAt;

@end
