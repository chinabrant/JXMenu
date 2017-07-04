//
//  JXMenuCellDataProtocol.h
//  JXSG_iOS
//
//  Created by brant on 2017/7/4.
//  Copyright © 2017年 Yanteng. All rights reserved.
//

#import <Foundation/Foundation.h>

// 菜单的数据接口
@protocol JXMenuCellDataProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *jxmenu_title;    // 要显示的菜单项的标题

@end
