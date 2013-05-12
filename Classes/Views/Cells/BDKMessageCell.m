#import "BDKMessageCell.h"

#import <BDKThirtySeven/BDKCFMessage.h>

@interface BDKMessageCell ()

@end

@implementation BDKMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(BDKCFMessage *)message {
    _message = message;

    if (![(NSNull *)message.body isEqual:[NSNull null]]) {
        self.textLabel.text = message.body;
        self.textLabel.font = [UIFont appFontOfSize:12];
    }
}

@end
