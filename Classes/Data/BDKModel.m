#import "BDKModel.h"

@implementation BDKModel

+ (id)modelWithBDKCFModel:(BDKCFModel *)model
{
    return [[self alloc] initWithBDKCFModel:model];
}

- (id)initWithBDKCFModel:(BDKCFModel *)model
{
    if ((self = [[self class] createEntity])) {
        
    }
    return self;
}

- (void)updateWithBDKCFModel:(BDKCFModel *)model { }

@end
