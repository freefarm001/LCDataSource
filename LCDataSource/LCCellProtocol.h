//
//  LCCellProtocol.h
//  CommonDataSource
//
//  Created by lc on 2017/7/27.
//  Copyright © 2017年 liuchang. All rights reserved.
//

#import "LCCellModelProtocol.h"

#ifndef LCCellProtocol_h
#define LCCellProtocol_h

/** cell所要遵守的协议 */
@protocol LCCellProtocol <NSObject>

/** 根据model设置cell */
- (void)configureCell:(id<LCCellModelProtocol>)model;

@end


#endif /* LCCellProtocol_h */
