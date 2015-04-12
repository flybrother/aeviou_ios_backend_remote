//
//  AIBPinyinForest.h
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIBPinyinNode.h"
#import "AIBPinyinRoot.h"

@class AIBPinyinNode;

@interface AIBPinyinForest : NSObject

-(AIBPinyinNode *)getNodeByOffset:(int)offset;


@end
