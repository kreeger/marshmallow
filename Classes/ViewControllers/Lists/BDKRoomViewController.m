#import "BDKRoomViewController.h"

#import "BDKRoomCollectionCell.h"

#import "BDKCampfireClient.h"
#import "BDKCFRoom.h"
#import "BDKRoom.h"
#import "BDKCFMessage.h"
#import "BDKMessage.h"

@interface BDKRoomViewController ()

/** The messages to be displayed in the room.
 */
@property (strong, nonatomic) NSArray *messages;

/** An initializer that takes a BDKRoom and sets everything up all nice.
 *  @param room The room to be displayed in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(BDKRoom *)room;

/** Gets the message associated with a given index path.
 *  @param indexPath The index path for which to retrieve the message.
 *  @returns A message.
 */
- (BDKMessage *)messageForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BDKRoomViewController

@synthesize room = _room, flowLayout = _flowLayout;

+ (id)vcWithRoom:(BDKRoom *)room
{
    return [[self alloc] initWithRoom:room];
}

- (id)initWithRoom:(BDKRoom *)room
{
    if (self = [super initWithIdentifier:room.name]) {
        _room = room;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView registerClass:[BDKRoomCollectionCell class]
            forCellWithReuseIdentifier:kBDKRoomCollectionCellId];
    
    self.messages = [NSArray array];
    self.title = self.room.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray *messageIds = [NSMutableArray array];
    [self.campfireClient getMessagesForRoom:self.room.identifier sinceMessageId:nil success:^(NSArray *result) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [result each:^(BDKCFMessage *message) {
                [messageIds addObject:[[BDKMessage createOrUpdateWithModel:message inContext:localContext] identifier]];
            }];
        } completion:^(BOOL success, NSError *error) {
            self.messages = [BDKMessage findAllWithIdentifiers:messageIds
                                                      sortedBy:@"createdAt"
                                                     ascending:NO
                                                     inContext:[NSManagedObjectContext defaultContext]];
            [self.collectionView reloadData];
        }];
    } failure:^(NSError *error, NSInteger responseCode) {
        DDLogError(@"Error %i getting messages. %@", responseCode, error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties

- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(302, 88);
    _flowLayout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.minimumLineSpacing = 5;
    return _flowLayout;
}

#pragma mark - Methods

- (BDKMessage *)messageForIndexPath:(NSIndexPath *)indexPath
{
    return self.messages[indexPath.row];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDKRoomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBDKRoomCollectionCellId
                                                                            forIndexPath:indexPath];
    BDKMessage *message = [self messageForIndexPath:indexPath];
    cell.label.text = message.body;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionViewDelegate

@end
