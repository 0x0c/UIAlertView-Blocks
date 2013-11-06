//
//  UIAlertView+blocks.h
//  GraphChat
//
//  Created by 暁 松田 on 12/01/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <objc/runtime.h>

@interface UIAlertViewBlocks : NSObject <UIAlertViewDelegate>
{
	void (^selectedBlock_)(NSInteger buttonIndex);
}

- (id)initWithBlock:(void (^)(NSInteger buttonIndex))resultBlock;

@end

@interface UIAlertView (Blocks)

@property (nonatomic, assign) UIAlertViewBlocks *blocksDelegate_;

- (id)initWithTitle:(NSString *)title message:(NSString *)message selectedBlock:(void (^)(NSInteger index))selectedBlock  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... ;

@end