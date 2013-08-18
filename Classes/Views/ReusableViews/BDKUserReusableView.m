#import "BDKUserReusableView.h"

#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <AGMedallionView/AGMedallionView.h>

NSString * const BDKUserResuableViewID = @"BDKUserResuableView";

@interface BDKUserReusableView ()

@property (strong, nonatomic) UIActivityIndicatorView *imageProgressView;

/**
 Common view layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKUserReusableView

@synthesize userLabel = _userLabel;
@synthesize userImageView = _userImageView;

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.userImageView];
    [self addSubview:self.userLabel];
    
    [self.userImageView makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.centerY.equalTo(self);
    }];
    
    [self.userLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.userImageView.trailing).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.top.equalTo(self);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.userLabel.text = nil;
}

#pragma mark - Properties

- (UILabel *)userLabel {
    if (_userLabel) return _userLabel;
    _userLabel = [UILabel new];
    _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _userLabel.textColor = [UIColor whiteColor];
    _userLabel.backgroundColor = [UIColor clearColor];
    _userLabel.font = [UIFont systemFontOfSize:14];
    return _userLabel;
}

- (AGMedallionView *)userImageView {
    if (_userImageView) return _userImageView;
    _userImageView = [AGMedallionView new];
    _userImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _userImageView.imageFillColor = [UIColor whiteColor];
    _userImageView.borderWidth = 1;
    _userImageView.borderColor = [UIColor lightGrayColor];
    _userImageView.shadowBlur = 0;
    _userImageView.shadowColor = [UIColor clearColor];
    _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _userImageView;
}

- (UIActivityIndicatorView *)imageProgressView {
    if (_imageProgressView) return _imageProgressView;
    _imageProgressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _imageProgressView.backgroundColor = [UIColor clearColor];
    return _imageProgressView;
}

#pragma mark - Public methods

- (void)setUserName:(NSString *)userName {
    self.userLabel.text = userName;
}

- (void)setAvatarURL:(NSURL *)avatarURL {
    [self.userImageView addSubview:self.imageProgressView];
    [self.imageProgressView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageProgressView.superview);
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:avatarURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:0];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        [self.imageProgressView removeFromSuperview];
        UIImage *image = [UIImage imageWithData:responseObject scale:[[UIScreen mainScreen] scale]];
        self.userImageView.image = image;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.imageProgressView removeFromSuperview];
        self.userImageView.backgroundColor = [UIColor redColor];
    }];
    
    [operation start];
}

@end
