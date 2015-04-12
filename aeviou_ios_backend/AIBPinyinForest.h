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

- (AIBPinyinNode *) findNodeOfPinyinNumbers:(NSArray *)pinyinNumbers ByOffset:(int)offset;  // 在词语森林中偏移量为offset的词语树里搜寻pinyinNumbers为拼音编号的拼音序列,返回nil如果没有找到

//-(AIBPinyinNode *)getNodeByOffset:(int)offset;


@end
