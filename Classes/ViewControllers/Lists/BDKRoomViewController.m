#import "BDKRoomViewController.h"

#import "IFBKRoomManager.h"
#import "IFBKMessageSet.h"

#import "IFBKCFRoom.h"
#import "IFBKCFMessage.h"
#import "IFBKUser.h"

#import "BDKMessageCell.h"
#import "BDKEnterKickCell.h"
#import "BDKTimestampCell.h"
#import "BDKTextLabelCell.h"
#import "BDKLabelReusableView.h"
#import "BDKFloatingHeaderFlowLayout.h"

#import <IFBKThirtySeven/IFBKCampfireClient.h>
#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/NSObject+BDKKit.h>

#import "IFBKCFMessage+DataHelpers.h"
#import "IFBKRoomManager+UIKit.h"
#import "NSUserDefaults+App.h"
#import "UIFont+App.h"

@interface BDKRoomViewController ()

@property (strong, nonatomic) NSMutableDictionary *cellHeights;

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @return An instance of self.
 */
- (instancetype)initWithRoomManager:(IFBKRoomManager *)roomManager;

/** Calculates the height of a message.
 *  @param message The message to be used in the cell.
 *  @return An approximated float value.
 */
- (CGFloat)cellHeightForMessage:(IFBKCFMessage *)message;

@end

@implementation BDKRoomViewController

@synthesize roomManager = _roomManager;

+ (instancetype)vcWithRoomManager:(IFBKRoomManager *)roomManager {
    return [[self alloc] initWithRoomManager:roomManager];
}

- (instancetype)initWithRoomManager:(IFBKRoomManager *)roomManager {
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
    [self.collectionView registerClass:[BDKEnterKickCell class] forCellWithReuseIdentifier:BDKEnterKickCellID];
    [self.collectionView registerClass:[BDKMessageCell class] forCellWithReuseIdentifier:BDKMessageCellID];
    [self.collectionView registerClass:[BDKTextLabelCell class] forCellWithReuseIdentifier:BDKTextLabelCellID];
    [self.collectionView registerClass:[BDKTimestampCell class] forCellWithReuseIdentifier:BDKTimestampCellID];
    
    [self.collectionView registerClass:[BDKLabelReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:BDKLabelReusableViewID];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // TODO: Don't join if room is already "joined" to.
//    [self.roomManager joinRoom:^{
//        DDLogAPI(@"Room joined.");
//    } failure:^(NSError *error) {
//        DDLogWarn(@"Failed to join room. %@.", error);
//    }];
    
    [self.roomManager startStreamingMessages:^{
        DDLogAPI(@"Began streaming.");
    } failure:^(NSError *error) {
        DDLogWarn(@"Could not start streaming. %@", error.localizedDescription);
        [self.roomManager startStreamingMessages:^{
            DDLogAPI(@"Second attempt to begin streaming succeeded.");
        } failure:^(NSError *error) {
            DDLogWarn(@"Final error for streaming. %@", error);
        }];
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
    BDKLabelReusableView *userView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:BDKLabelReusableViewID
                                                                               forIndexPath:indexPath];
    userView.label.text = [self.roomManager headerForSection:indexPath.section];;
    return userView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFBKCFMessage *message = [self.roomManager messageForIndexPath:indexPath];
    switch (message.messageType) {
        case IFBKMessageTypeText:
        case IFBKMessageTypePaste: {
            BDKMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKMessageCellID forIndexPath:indexPath];
            [cell setMessage:message.body timestamp:message.createdAtDisplay];
            cell.paste = message.messageType == IFBKMessageTypePaste;
            return cell;
        }
        case IFBKMessageTypeTimestamp: {
            BDKTimestampCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKTimestampCellID forIndexPath:indexPath];
            [cell setTimestampText:message.createdAtDisplay];
            return cell;
        }
        case IFBKMessageTypeKick:
        case IFBKMessageTypeEnter: {
            BDKEnterKickCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDKEnterKickCellID forIndexPath:indexPath];
            IFBKUser *user = [message user];
            [cell setUsername:user.name timestamp:message.createdAtDisplay isEntering:(message.messageType == IFBKMessageTypeEnter)];
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
    IFBKCFMessage *message = [self.roomManager messageForIndexPath:indexPath];
    return CGSizeMake(320, [self cellHeightForMessage:message]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(320, 24);
}

#pragma mark - UICollectionViewDelegate

@end
