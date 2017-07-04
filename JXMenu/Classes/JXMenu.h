//
//  JXMenu.h
//  JXSG_iOS
//
//  Created by brant on 2017/7/3.
//  Copyright © 2017年 Yanteng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JXMenuAction) (id data, NSInteger index);

/*
 功能：显示一个带小箭头的菜单
 
 待实现功能：
 * 自定义padding
 * 自定义箭头
 * 自定义边框颜色 
 * 自定义圆角大小
 * 自定义菜单项   // 菜单项目上可能有图片，可能有红点等等要定制
 
 */
@interface JXMenu : UIView

@property (nonatomic, copy) JXMenuAction action;


/**
 显示一个菜单到指定的view上

 @param view 要添加到view
 @param point 左侧的一个顶点
 @param isTop 是不是左上角
 @param width 菜单的整体宽度
 @param items 这个array 里面的单个数据可以是对象，要实现 /JXMenuCellDataProtocol/
 */
+ (JXMenu *)showInView:(UIView *)view point:(CGPoint)point isTop:(BOOL)isTop width:(CGFloat)width menuItems:(NSArray *)items;

@end
