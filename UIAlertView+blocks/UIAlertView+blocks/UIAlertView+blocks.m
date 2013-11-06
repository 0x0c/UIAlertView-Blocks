//
//  UIAlertView+blocks.m
//  GraphChat
//
//  Created by 暁 松田 on 12/01/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+blocks.h"

@implementation UIAlertViewBlocks

- (id)initWithBlock:(void (^)(NSInteger buttonIndex))resultBlock
{
	self = [super init];
	if (self) {
#if !__has_feature(objc_arc)
		selectedBlock_ = Block_copy(resultBlock);
#else
		selectedBlock_ = [resultBlock copy];
#endif
	}
	
	return self;
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
	Block_release(selectedBlock_);
	[super dealloc];
#endif
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	selectedBlock_(buttonIndex);
}

@end


@implementation UIAlertView (Blocks)

@dynamic blocksDelegate_;

- (void)setBlocksDelegate_:(UIAlertViewBlocks *)blocksDelegate_
{
	objc_setAssociatedObject(self, @"blocksDelegate", blocksDelegate_, OBJC_ASSOCIATION_RETAIN);
}

- (id)delegate_
{
	return (id)objc_getAssociatedObject(self, @"blocksDelegate");
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message selectedBlock:(void (^)(NSInteger index))selectedBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... 
{
	self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
	if (self) {
		va_list args;
		va_start(args, otherButtonTitles);
		for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
			[self addButtonWithTitle:arg];
		}
		va_end(args);
		
		UIAlertViewBlocks *blocksDelegate = [[UIAlertViewBlocks alloc] initWithBlock:selectedBlock];
		[self setBlocksDelegate_:blocksDelegate];
#if !__has_feature(objc_arc)
		[blocksDelegate release];
#endif
		self.delegate = blocksDelegate;
	}
	
	return self;
}

@end