#import "BDKRoomViewController.h"

#import "IFBKRoomManager.h"
#import "IFBKMessageSet.h"

#import "BDKMessageCell.h"
#import "BDKTableHeaderView.h"

#import "IFBKCFRoom.h"
#import "IFBKCFMessage.h"
#import "IFBKUser.h"

#import <IFBKThirtySeven/IFBKCampfireClient.h>
#import <BDKGeometry/BDKGeometry.h>

@interface BDKRoomViewController ()

@property (strong, nonatomic) NSMutableDictionary *cellHeights;

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoomManager:(IFBKRoomManager *)roomManager;

/** Calculates the height of a message.
 *  @param message The message to be used in the cell.
 *  @returns An approximated float value.
 */
- (CGFloat)cellHeightForMessage:(IFBKCFMessage *)message;

@end

@implementation BDKRoomViewController

@synthesize roomManager = _roomManager;

+ (id)vcWithRoomManager:(IFBKRoomManager *)roomManager {
    return [[self alloc] initWithRoomManager:roomManager];
}

- (id)initWithRoomManager:(IFBKRoomManager *)roomManager {
    if (self = [super initWithIdentifier:roomManager.room.name]) {
        _roomManager = roomManager;
        __weak BDKRoomViewController *unretainedSelf = self;
        _roomManager.didReceiveMessageBlock = ^(IFBKCFMessage *message) {
            [unretainedSelf.collectionView reloadData];
            // TODO: don't do this if the user isn't at max-y content offset (if they're currently scrolled-up)
            [unretainedSelf.collectionView scrollToItemAtIndexPath:[unretainedSelf.roomManager maxIndexPath]
                                            atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.roomManager.room.name;
}

- (void)registerCellTypes {
    [self.collectionView registerClass:[BDKMessageCell class] forCellWithReuseIdentifier:kBDKMessageCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.roomManager loadRoomAndHistory:^{
        self.cellHeights = [NSMutableDictionary dictionaryWithCapacity:[self.roomManager.messages count]];
        [self.roomManager.messages enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *msgs, BOOL *stop) {
            self.cellHeights[key] = [NSMutableArray arrayWithCapacity:[msgs count]];
            [msgs enumerateObjectsUsingBlock:^(IFBKCFMessage *msg, NSUInteger idx, BOOL *stop) {
                CGFloat h = [self cellHeightForMessage:msg];
                [self.cellHeights[key] addObject:@(h)];
            }];
        }];
    } failure:^(NSError *error) {
        // pass for now
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // TODO: Don't join if room is already "joined" to.
    [self.roomManager joinRoom:^{
        DDLogAPI(@"Room joined.");
    } failure:^(NSError *error) {
        DDLogWarn(@"Failed to join room. %@.", error);
    }];
    
    [self.roomManager startStreamingMessages:^{
        DDLogAPI(@"Began streaming.");
    } failure:^(NSError *error) {
        DDLogWarn(@"Could not start streaming. %@", error.localizedDescription);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.roomManager stopStreamingMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods

- (CGFloat)cellHeightForMessage:(IFBKCFMessage *)message {
    return 80;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.roomManager numberOfMessageSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.roomManager messagesForSection:section] count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [[self.roomManager userForSection:section] name];
//}

- (BDKMessageCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDKMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBDKMessageCellID forIndexPath:indexPath];
    cell.message = [self.roomManager messageAtSection:indexPath.section row:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 80);
}

#pragma mark - UICollectionViewDelegate

@end
