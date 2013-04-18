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
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

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

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
    
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
            [self.resultsController performFetch:nil];
            [self.tableView reloadData];
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

- (NSFetchedResultsController *)resultsController
{
    if (_resultsController) return _resultsController;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"BDKMessage"];
    request.predicate = [NSPredicate predicateWithFormat:@"roomIdentifier = %@", self.room.identifier];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES]];
    request.fetchBatchSize = 30;
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:[NSManagedObjectContext defaultContext]
                                                               sectionNameKeyPath:nil
                                                                        cacheName:nil];
    return _resultsController;
}

#pragma mark - Methods

- (BDKMessage *)messageForIndexPath:(NSIndexPath *)indexPath
{
    return [self.resultsController objectAtIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.resultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    BDKMessage *message = [self messageForIndexPath:indexPath];
    cell.textLabel.text = message.body;
    cell.textLabel.font = [UIFont appFontOfSize:12];
    return cell;
}

#pragma mark - UITableViewDelegate

@end
