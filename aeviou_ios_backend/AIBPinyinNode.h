//
//  AIBPinyinNode.h
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIBPinyinNode : NSObject

@property (nonatomic) BOOL isWordNode;             // 用于表示这个节点是中间节点还是可以组成词语的节点
@property (nonatomic) int pinyinNumber;            // 拼音编号
@property (nonatomic) int offsetInPHanzi;          // 在phanzi中的偏移以找到对应的汉字
@property (nonatomic) int maxFrequency;            //每个词语都有一个出现次数，以表现该词语在汉语中的常用性。例如“shang”，其可能对应的汉字有“上”、“尚”等，去出现频率最高的“上”字的频率，记为“shang”的maxFreqency
@property (nonatomic) int childrenSize;            // 子节点个数
@property (nonatomic) int childrenOffsetInPNode;   // 第一个子节点在词语森林中的偏移

@end
