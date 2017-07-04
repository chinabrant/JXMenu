//
//  JXMenuCell.h
//  JXSG_iOS
//
//  Created by brant on 2017/7/4.
//  Copyright © 2017年 Yanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXMenuCellDataProtocol.h"

@interface JXMenuCell : UITableViewCell

+ (NSString *)cellIdentifier;

@property (nonatomic, strong) id <JXMenuCellDataProtocol> data;


@end
