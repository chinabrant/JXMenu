//
//  JXMenuCell.m
//  JXSG_iOS
//
//  Created by brant on 2017/7/4.
//  Copyright © 2017年 Yanteng. All rights reserved.
//

#import "JXMenuCell.h"
#import <Masonry/Masonry.h>

@interface JXMenuCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JXMenuCell

+ (NSString *)cellIdentifier {
    return @"JXMenuCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        
        [self layout];
    }
    
    return self;
}

- (void)layout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(id<JXMenuCellDataProtocol>)data {
    _data = data;
    
    self.titleLabel.text = data.jxmenu_title;
}

#pragma mark - lazy load

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

@end
