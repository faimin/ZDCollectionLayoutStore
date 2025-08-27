//
//  ZDHorizontalLineLayout.h
//  Zero.D.Saber
//
//  Created by Zero.D.Saber on 2018/12/13.
//  Copyright © 2018 Zero.D.Saber. All rights reserved.
//
//  Banner分页布局，如表情面板

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZDHorizontalLineLayoutDelegate <NSObject>

- (CGSize)calculateItemSizeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZDHorizontalLineLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZDHorizontalLineLayoutDelegate> delegate;

/// contentView内边距(正数=内缩,负数=外扩)
@property (nonatomic, assign) UIEdgeInsets contentInsets;
/// item之间的横向间距
@property (nonatomic, assign) CGFloat itemSpacing;

@end

NS_ASSUME_NONNULL_END
