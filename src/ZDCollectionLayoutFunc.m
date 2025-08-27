#import "ZDCollectionLayoutFunc.h"

NSArray<UICollectionViewLayoutAttributes *> *ZDCollectionLayoutAttributesForElementsInRect(CGRect rect, NSArray<UICollectionViewLayoutAttributes *> *cachedLayouts) {
    if (cachedLayouts.count == 0) return @[];
    
    CGFloat rect_top = CGRectGetMinY(rect);
    CGFloat rect_bottom = CGRectGetMaxY(rect);
    
    NSUInteger beginIndex = 0;
    NSUInteger endIndex = cachedLayouts.count;
    NSUInteger middleIndex = (beginIndex + endIndex) / 2;
    
    UICollectionViewLayoutAttributes *middleAttributes = cachedLayouts[middleIndex];
    
    while (CGRectEqualToRect(CGRectIntersection(middleAttributes.frame, rect), CGRectZero)) {
        CGFloat middle_top = CGRectGetMinY(middleAttributes.frame);
        CGFloat middle_bottom = CGRectGetMaxY(middleAttributes.frame);
        
        // 在前半部分查找
        if (rect_bottom < middle_top) {
            endIndex = middleIndex;
        }
        // 在后半部分查找
        else if (rect_top > middle_bottom) {
            beginIndex = middleIndex;
        }
        middleIndex = (beginIndex + endIndex) / 2;
        
        middleAttributes = cachedLayouts[middleIndex];
    }
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *targetAttributes = @[].mutableCopy;
    for (NSInteger i = middleIndex; i >= 0; --i) {
        UICollectionViewLayoutAttributes *attributes = cachedLayouts[i];
        if (CGRectGetMaxY(attributes.frame) >= rect_top) {
            [targetAttributes insertObject:attributes atIndex:0];
        }
        else {
            break;
        }
    }
    
    for (NSInteger i = middleIndex+1; i < cachedLayouts.count; i++) {
        UICollectionViewLayoutAttributes *attributes = cachedLayouts[i];
        if (CGRectGetMinY(attributes.frame) <= rect_bottom) {
            [targetAttributes addObject:attributes];
        }
        else {
            break;
        }
    }
    
    return targetAttributes;
}