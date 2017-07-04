//
//  JXMenu.m
//  JXSG_iOS
//
//  Created by brant on 2017/7/3.
//  Copyright © 2017年 Yanteng. All rights reserved.
//

#import "JXMenu.h"
#import "JXMenuCell.h"
#import "UIView+Positioning.h"

const CGFloat kMenuHeight = 35; // 菜单项的高度
const CGFloat kArrowHeight = 5; // 箭头的高度

@interface JXMenu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, strong) UITableView *itemsTableView;

@property (nonatomic, copy) NSArray *menuItems;

@property (nonatomic) CGPoint leftPoint;    // 给到的左边的一个顶点
@property (nonatomic) BOOL isTop;   // 给到的leftPoint是上顶部的点还是底部的点

@property (nonatomic, strong) UIImageView *arrowImageView;  // 菜单上的小箭头

@property (nonatomic, weak) UIView *attachView; // 添加到的view，就是父view

@property (nonatomic) CGFloat menuWidth;

@end

@implementation JXMenu

+ (JXMenu *)showInView:(UIView *)view point:(CGPoint)point isTop:(BOOL)isTop width:(CGFloat)width menuItems:(NSArray *)items {
    
    JXMenu *menu = [[JXMenu alloc] initWithFrame:view.bounds];
    
    menu.leftPoint = point;
    menu.attachView = view;
    menu.menuWidth = width;
    menu.menuItems = items;
    
    // 一定要赋值完成后再setupViews
    [menu setupViews];
    
    [view addSubview:menu];
    
    // 显示动画
    [menu showAnimation];
    
    return menu;
}

- (void)setupViews {
//    NSInteger itemCount = self.menuItems.count;
    
    // 最低层的view 它的高度是不包含箭头的高度的
    [self addSubview:self.menuView];
    self.menuView.origin = [self menuOrigin];
    self.menuView.size = CGSizeMake(self.menuWidth, [self calculateHeight]);
    
    [self.menuView addSubview:self.itemsTableView];
    self.itemsTableView.frame = self.menuView.bounds;
    
    [self addSubview:self.arrowImageView];
    self.arrowImageView.origin = CGPointMake(self.menuView.centerX - self.arrowImageView.width / 2.0, self.leftPoint.y - kArrowHeight - 0.5);
}

// menu的高度, 这个高度是不包含箭头的高度的
- (CGFloat)calculateHeight {
    
    NSInteger itemCount = self.menuItems.count;
    
    // 计算一下，不能超过父view的高度   kArrowHeight是下面箭头的高度
    CGFloat hei = itemCount * kMenuHeight + kArrowHeight;
    if (self.isTop) {
        if (self.leftPoint.y + hei + 10 > self.attachView.height) {
            hei = self.attachView.height - self.leftPoint.y - 10;
        }
    }
    else {
        if (self.leftPoint.y - 10 - hei < 0) {
            hei = self.leftPoint.y - 10;
        }
    }
    
    return hei - kArrowHeight;
}

// 菜单右上角的位置
- (CGPoint)menuOrigin {
    if (self.isTop) {
        return self.leftPoint;
    }
    
    return CGPointMake(self.leftPoint.x, self.leftPoint.y - [self calculateHeight] - kArrowHeight);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[JXMenuCell cellIdentifier]];
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.data = self.menuItems[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.action) {
        self.action(self.menuItems[indexPath.row], indexPath.row);
    }
    
    [self hide];
}

#pragma mark - private

- (void)showAnimation {
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
       
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

#pragma mark - lazy load

- (UIView *)menuView {
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.layer.borderWidth = 0.5;
        _menuView.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        _menuView.layer.cornerRadius = 5.0;
        _menuView.layer.masksToBounds = YES;
    }
    
    return _menuView;
}

- (UITableView *)itemsTableView {
    if (!_itemsTableView) {
        _itemsTableView = [[UITableView alloc] init];
        _itemsTableView.rowHeight = kMenuHeight;
        
        [_itemsTableView registerClass:[JXMenuCell class] forCellReuseIdentifier:[JXMenuCell cellIdentifier]];
        
        _itemsTableView.dataSource = self;
        _itemsTableView.delegate = self;
        _itemsTableView.separatorColor = [UIColor colorWithHexString:@"edebeb"];
        _itemsTableView.layoutMargins = UIEdgeInsetsZero;
        _itemsTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    return _itemsTableView;
}

// 10x5
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"personal_shop_fl_jt_icon"];
        [_arrowImageView sizeToFit];
    }
    
    return _arrowImageView;
}

@end
