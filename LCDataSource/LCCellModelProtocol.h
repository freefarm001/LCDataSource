//
//  LCCellModelProtocol.h
//  CommonDataSource
//
//  Created by lc on 2017/7/27.
//  Copyright © 2017年 liuchang. All rights reserved.
//

#ifndef LCCellModelProtocol_h
#define LCCellModelProtocol_h

/** model所要遵守的协议 */
@protocol LCCellModelProtocol <NSObject>

/** 获取模型对应的cell的重用标示符 */
- (NSString *)getCellIndetifier;

/** 获取模型对应的cell的类型 */
- (Class)cellClass;

/** 获取模型对应cell的高度 */
- (double)calculateHeightForCell;

@end

#endif /* LCCellModelProtocol_h */
