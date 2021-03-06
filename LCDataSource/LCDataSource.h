//
//  LCDataSource.h
//  CommonDataSource
//
//  Created by lc on 2017/7/27.
//  Copyright © 2017年 liuchang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCCellProtocol.h"

/** TableView / CollectionView 的数据源 */
@interface LCDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

- (id<LCCellModelProtocol>)modelAtIndexPath:(NSIndexPath *)indexPath;

/** model数组（数据只有一个分组的时候也要把数据放入到数组中） */
@property (strong, nonatomic) NSArray<NSArray *> *models;

@end
