//
//  UIScrollView+RCEmpty.m
//  RCEmptyView
//
//  Created by RongCheng on 2018/3/27.
//  Copyright © 2018年 MBRB. All rights reserved.
//

#import "UIScrollView+RCEmpty.h"
#import <objc/runtime.h>
#import "EmptyView.h"
@implementation NSObject (Empty)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}
@end

@implementation UIScrollView (RCEmpty)
static char kRCEmptyViewKey;
- (void)setRc_emptyView:(EmptyView *)rc_emptyView{
    if(rc_emptyView != self.rc_emptyView){
        objc_setAssociatedObject(self, &kRCEmptyViewKey, rc_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.rc_emptyView.frame = self.bounds;
        [self addSubview:self.rc_emptyView];
    }
}
- (EmptyView *)rc_emptyView{
    return  objc_getAssociatedObject(self, &kRCEmptyViewKey);
}
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    //没有设置rc_emptyView的，直接返回
    if (!self.rc_emptyView) {
        return;
    }
    if ([self totalDataCount] == 0) {
        self.rc_emptyView.hidden = NO;
        [self bringSubviewToFront:self.rc_emptyView];
    }else{
        self.rc_emptyView.hidden = YES;
    }
}
@end


#pragma mark - ------------------ UITableView ------------------
@implementation UITableView (RCEmpty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(rc_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(rc_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(rc_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(rc_reloadSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(rc_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(rc_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(rc_reloadRowsAtIndexPaths:withRowAnimation:)];
}
///section
- (void)rc_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)rc_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)rc_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_reloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)rc_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)rc_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)rc_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self rc_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)rc_reloadData{
    [self rc_reloadData];
    [self getDataAndSet];
}
@end


#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(rc_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(rc_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(rc_deleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(rc_reloadSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(rc_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(rc_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(rc_reloadItemsAtIndexPaths:)];
    
}
- (void)rc_reloadData{
    [self rc_reloadData];
    [self getDataAndSet];
}
///section
- (void)rc_insertSections:(NSIndexSet *)sections{
    [self rc_insertSections:sections];
    [self getDataAndSet];
}
- (void)rc_deleteSections:(NSIndexSet *)sections{
    [self rc_deleteSections:sections];
    [self getDataAndSet];
}
- (void)rc_reloadSections:(NSIndexSet *)sections{
    [self rc_reloadSections:sections];
    [self getDataAndSet];
}

///item
- (void)rc_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self rc_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)rc_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self rc_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)rc_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self rc_reloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end



#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (RCEmpty)


@end
