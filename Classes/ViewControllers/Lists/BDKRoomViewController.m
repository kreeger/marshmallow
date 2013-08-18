#import "BDKRoomViewController.h"

#import "IFBKRoomManager.h"
#import "IFBKMessageSet.h"

#import "IFBKCFRoom.h"
#import "IFBKCFMessage.h"
#import "IFBKUser.h"

#import "BDKMessageCell.h"
#import "BDKTimestampCell.h"
#import "BDKTextLabelCell.h"
#import "BDKUserReusableView.h"

#import <IFBKThirtySeven/IFBKCampfireClient.h>
#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/NSObject+BDKKit.h>

#import "NSUserDefaults+App.h"
#import "UIFont+App.h"

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

/**
 Common logic for determining whether or not to show a header view at a given section.
 
 @param section The section to be used in the lookup.
 @return If a user is to be shown for a section, this returns the user. Otherwise, nil.
 */
- (IFBKUser *)userForSection:(NSInteger)section;

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

- (void)registerCellTypes {
    [self.collectionView registerClass:[BDKMessageCell class] forCellWithReuseIdentifier:BDKMessageCellID];
    [self.collectionView registerClass:[BDKTimestampCell class] forCellWithReuseIdentifier:BDKTimestampCellID];
    [self.collectionView registerClass:[BDKTextLabelCell class] forCellWithReuseIdentifier:BDKTextLabelCellID];
    
    [self.collectionView registerClass:[BDKUserReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:BDKUserResuableViewID];
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

#pragma mark - Private methods

- (CGFloat)cellHeightForMessage:(IFBKCFMessage *)message {
    if ([message.body isNull]) return 30;
    
    CGRect rect = [message.body boundingRectWithSize:CGSizeMake(240, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}
                                             context:nil];
    DDLogUI(@"Generated size %@.", NSStringFromCGRect(rect));
    return 30 + rect.size.height;
}

- (IFBKUser *)userForSection:(NSInteger)section {
    IFBKCFMessage *firstMessage = [self.roomManager messageAtSection:section row:0];
    if (firstMessage.messageType != IFBKMessageTypeText) {
        return nil;
    }
    
    return [self.roomManager userForSection:section];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.roomManager numberOfMessageSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.roomManager messagesForSection:section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    IFBKUser *user = [self userForSection:indexPath.section];
    if (!user) {
        return nil;
    }
    
    BDKUserReusableView *userView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                       withReuseIdentifier:BDKUserResuableViewID
                                                                              forIndexPath:indexPath];
    [userView setUserName:user.name];
    [userView setAvatarURL:user.avatarUrlValue];
    return userView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.roomManager userForSection:section] name];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFBKCFMessage *message = [self.roomManager messageAtSection:indexPath.section row:indexPath.row];
    switch (message.messageType) {
        case IFBKMessageTypeText: {
            BDKMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKMessageCellID forIndexPath:indexPath];
            [cell setMessageText:message.body timestampText:message.createdAtDisplay];
            return cell;
        }
        case IFBKMessageTypeTimestamp: {
            BDKTimestampCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKTimestampCellID forIndexPath:indexPath];
            [cell setTimestampText:message.createdAtDisplay];
            return cell;
        }
        case IFBKMessageTypeEnter: {
            BDKTextLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKTextLabelCellID forIndexPath:indexPath];
            IFBKUser *user = [self.roomManager userForSection:indexPath.section];
            [cell setBodyText:[NSString stringWithFormat:@"%@ joined", user.name]];
            return cell;
        }
        case IFBKMessageTypeKick: {
            BDKTextLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKTextLabelCellID forIndexPath:indexPath];
            IFBKUser *user = [self.roomManager userForSection:indexPath.section];
            [cell setBodyText:[NSString stringWithFormat:@"%@ left", user.name]];
            return cell;
        }
        default: {
            BDKTextLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKTextLabelCellID forIndexPath:indexPath];
            [cell setBodyText:[message description]];
            return cell;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFBKCFMessage *message = [self.roomManager messageAtSection:indexPath.section row:indexPath.row];
    return CGSizeMake(320, [self cellHeightForMessage:message]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    IFBKUser *user = [self userForSection:section];
    return user ? CGSizeMake(320, 24) : CGSizeZero;
}

#pragma mark - UICollectionViewDelegate

@end
