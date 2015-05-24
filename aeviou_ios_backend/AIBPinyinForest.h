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

- (NSMutableArray *)getSearchMatrixColumnForPinyinNumbers:(NSArray *)pinyinNumbers; // 在词语森林中从第一个拼音（根节点）的词语树里构造searchMatrix所需要的column array（即从根节点开始连续i个拼音组成的拼音序列组成的词，填入array中并返回）

//-(AIBPinyinNode *)getNodeByOffset:(int)offset;


@end
