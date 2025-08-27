//
//  ZDLeftAlignedLayout.h
//  Zero.D.Saber
//
//  Created by Zero.D.Saber on 2018/12/12.
//  Copyright © 2018 Zero.D.Saber. All rights reserved.
//
//  标签折行布局(单section,左对齐)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZDLeftAlignedLayoutDelegate <NSObject>

- (CGSize)calculateItemSizeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZDLeftAlignedLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZDLeftAlignedLayoutDelegate> delegate;

/// contentView内边距(正数=内缩,负数=外扩)
@property (nonatomic, assign) UIEdgeInsets contentInsets;
/// item之间的横向间距
@property (nonatomic, assign) CGFloat itemSpacing;
/// item之间的纵向间距
@property (nonatomic, assign) CGFloat lineSpacing;

@end

NS_ASSUME_NONNULL_END
