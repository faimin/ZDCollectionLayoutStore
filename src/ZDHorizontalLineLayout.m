//
//  ZDHorizontalLineLayout.m
//  Zero.D.Saber
//
//  Created by Zero.D.Saber on 2018/12/13.
//  Copyright © 2018 Zero.D.Saber. All rights reserved.
//

#import "ZDHorizontalLineLayout.h"
#import "ZDCollectionLayoutFunc.h"

@interface ZDHorizontalLineLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layoutCache;
@end

@implementation ZDHorizontalLineLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.layoutCache removeAllObjects];
    
    NSUInteger originX = self.contentInsets.left;
    NSUInteger originY = self.contentInsets.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < itemCount; ++i) {
        @autoreleasepool {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGSize itemSize = CGSizeZero;
            if ([self.delegate respondsToSelector:@selector(calculateItemSizeAtIndexPath:)]) {
                itemSize = [self.delegate calculateItemSizeAtIndexPath:indexPath];
            } else {
                NSCAssert(NO, @"Delegate must implement calculateItemSizeAtIndexPath:");
            }
            if (!CGRectIsEmpty((CGRect){CGPointZero, itemSize})) {
                CGRect lastItemFrame = self.layoutCache.lastObject.frame;
                CGFloat x = (i == 0) ? originX : CGRectGetMaxX(lastItemFrame) + self.itemSpacing;
                CGFloat y = originY;
                attributes.frame = (CGRect){x, y, itemSize};
                [self.layoutCache addObject:attributes];
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.layoutCache.count) {
        return nil;
    }
    return self.layoutCache[indexPath.item];
}

- (CGSize)collectionViewContentSize {
    CGFloat width = CGRectGetMaxX(self.layoutCache.lastObject.frame) + self.contentInsets.right;
    CGFloat height = CGRectGetMaxY(self.layoutCache.lastObject.frame) + self.contentInsets.bottom;
    return CGSizeMake(width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return ZDCollectionLayoutAttributesForElementsInRect(rect, self.layoutCache);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

#pragma mark - Property

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)layoutCache {
    if (!_layoutCache) {
        _layoutCache = @[].mutableCopy;
    }
    return _layoutCache;
}

@end
