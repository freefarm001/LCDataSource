//
//  LCDataSource.m
//  CommonDataSource
//
//  Created by lc on 2017/7/27.
//  Copyright © 2017年 liuchang. All rights reserved.
//

#import "LCDataSource.h"

@interface LCDataSource ()

/** 已注册的重用标识符数组 */
@property (strong, nonatomic) NSMutableSet<NSString *> *reusedIdentifierSet;

@end

@implementation LCDataSource

- (instancetype)initWithModels:(NSArray<NSArray *> *)models {
    if (self = [super init]) {
        _models = [models copy];
    }
    return self;
}

- (id<LCCellModelProtocol>)modelAtIndexPath:(NSIndexPath *)indexPath {
    return _models[indexPath.section][indexPath.row];
}

#pragma mark 🍀🍀 UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_models[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<LCCellModelProtocol> model = [self modelAtIndexPath:indexPath];
    
    NSAssert([model conformsToProtocol:@protocol(LCCellModelProtocol)], @"model没有遵守%@协议", NSStringFromProtocol(@protocol(LCCellModelProtocol)));
    
    //注册重用该标识符
    [self registerReusedIdentifierWithModel:model andView:tableView];
    
    UITableViewCell<LCCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:[model getCellIndetifier] forIndexPath:indexPath];
    
    NSAssert([cell conformsToProtocol:@protocol(LCCellProtocol)], @"cell没有遵守%@协议", NSStringFromProtocol(@protocol(LCCellProtocol)));
    
    [cell configureCell:model];
    
    return cell;
}

#pragma mark 🍀🍀 UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_models[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<LCCellModelProtocol> model = [self modelAtIndexPath:indexPath];
    
    NSAssert([model conformsToProtocol:@protocol(LCCellModelProtocol)], @"model没有遵守%@协议", NSStringFromProtocol(@protocol(LCCellModelProtocol)));
    
    //注册重用标识符
    [self registerReusedIdentifierWithModel:model andView:collectionView];
    
    UICollectionViewCell<LCCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[model getCellIndetifier] forIndexPath:indexPath];
    
    NSAssert([cell conformsToProtocol:@protocol(LCCellProtocol)], @"cell没有遵守%@协议", NSStringFromProtocol(@protocol(LCCellProtocol)));
    
    [cell configureCell:model];
    
    return cell;
}

#pragma mark 🍀🍀 判断当前重用标识符是否已注册

- (void)registerReusedIdentifierWithModel:(id<LCCellModelProtocol>)model andView:(UIView *)view {
    
    if (![self.reusedIdentifierSet containsObject:[model getCellIndetifier]]) {
        
        if ([view isKindOfClass:[UITableView class]]) {
            [(UITableView *)view registerClass:[model cellClass] forCellReuseIdentifier:[model getCellIndetifier]];
        }
        
        if ([view isKindOfClass:[UICollectionView class]]) {
            [(UICollectionView *)view registerClass:[model cellClass] forCellWithReuseIdentifier:[model getCellIndetifier]];
        }
        
        [self.reusedIdentifierSet addObject:[model getCellIndetifier]];
    }
}

#pragma mark 🍀🍀 lazy load

- (NSMutableArray<NSString *> *)reusedIdentifiers {
    if (!_reusedIdentifiers) {
        _reusedIdentifiers = [NSMutableArray arrayWithCapacity:0];
    }
    return _reusedIdentifiers;
}

@end
