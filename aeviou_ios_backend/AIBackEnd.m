//
//  AIBackEnd.m
//  aeviou_ios_backend
//
//  Created by Air on 3/28/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBackEnd.h"
#import "AIBPinyinTree.h"
#import "AIBPinyinRoot.h"
#import "AIBPinyinForest.h"
#import "AIBPinyinHanzi.h"

@implementation AIBackEnd{
    AIBPinyinTree *pinyinTree;
    AIBPinyinRoot *pinyinRoot;
    AIBPinyinForest *pinyinForest;
    AIBPinyinHanzi *pinyinHanzi;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        pinyinTree = [[AIBPinyinTree alloc] init];
        pinyinRoot = [[AIBPinyinRoot alloc] init];
        pinyinForest = [[AIBPinyinForest alloc] init];
        pinyinHanzi = [[AIBPinyinHanzi alloc] init];
        
//        int ret = -1;
//        ret = [pinyinRoot getOffsetOfPinyinNumber:288];
//        NSLog(@"ret is %d",ret);
////        AIBPinyinNode *node = [pinyinForest getNodeByOffset:ret];
//        AIBPinyinNode *node = [pinyinForest findNodeOfPinyinNumbers:@[@(113),@(267)] ByOffset:ret];
//        NSArray *arr = [pinyinHanzi getHanziArrayAtOffset:node.offsetInPHanzi];
    }
    return self;
}

-(NSMutableArray *)getHanziArrayByPinyin:(NSArray *)pinyins{
    // compose pinyin numbers array first eg.(@[@"shang",@"hai"] -> @[288,133])
    NSMutableArray *pinyinNumbers = NSMutableArray.new;
    for (int i=0; i<pinyins.count; i++) {
        [pinyinNumbers addObject:@([pinyinTree getNumberOfPinyin:pinyins[i]])];
    }
    
    // find root offset of root node
    int rootOffset = [pinyinRoot getOffsetOfPinyinNumber:((NSNumber *)pinyinNumbers[0]).intValue];
    // get node info
    AIBPinyinNode *node = [pinyinForest findNodeOfPinyinNumbers:[pinyinNumbers subarrayWithRange:NSMakeRange(1, pinyinNumbers.count-1)]  ByOffset:rootOffset];
    
    // get hanzi info from phanzi based on node info
    NSMutableArray *ret = NSMutableArray.new;
    ret = [pinyinHanzi getHanziArrayAtOffset:node.offsetInPHanzi];
    return ret;
}

-(NSString *)getSentenceByPinyin:(NSArray *)pinyins{
    if (pinyins.count <= 1) {
        return [[self getHanziArrayByPinyin:pinyins] firstObject];
    }
    // compose pinyin numbers array first eg.(@[@"shang",@"hai"] -> @[288,133])
    NSMutableArray *pinyinNumbers = NSMutableArray.new;
    for (int i=0; i<pinyins.count; i++) {
        [pinyinNumbers addObject:@([pinyinTree getNumberOfPinyin:pinyins[i]])];
    }
    
    // compose search matrix pinyin by pinyin (possible word made by the pinyin sequence starting from each pinyin of length 0,1,2....)
    NSMutableArray *searchMatrix = [self makeSearchMatrix:pinyinNumbers];
    NSMutableArray *inDegreeArray = [self makeInDegreeArrayBySearchMatrix:searchMatrix];

    NSMutableArray *longestPaths = NSMutableArray.new;  // 记录该节点最长路径的短句string
    NSMutableArray *weights = NSMutableArray.new;       // 记录该节点最长路径的权值
    
    [longestPaths addObject:[[searchMatrix firstObject] firstObject]];  // 初始化第一个节点
    [weights addObject:@(0)];
    
    for(int i=1;i<pinyinNumbers.count;i++){  // 从第二个节点开始顺序计算最长路径
        int maxWeight = -1;
        NSString *pathOfMaxWeight = @"";
        NSArray *inDegrees = [inDegreeArray objectAtIndex:i];

        // 初始时把前一个节点的权值+0作为该点权值
        maxWeight = ((NSNumber *)[weights objectAtIndex:i-1]).intValue;
        NSString *character = [[searchMatrix objectAtIndex:i] firstObject];
        pathOfMaxWeight = [[longestPaths objectAtIndex:i-1] stringByAppendingString:character];
        
        
        for (NSNumber *inNode in inDegrees) {  // 根据每个inNode来找出最长路径
            int inNodeIndex = inNode.intValue;
            int inNodeWeight;
            NSString *inNodeString;
            
            if (inNodeIndex == 0) {  // 边界检查，如果是从第一个拼音开始的短句，入节点不提供信息
                inNodeWeight = 0;
                inNodeString = @"";
            } else {
                inNodeWeight = ((NSNumber *)[weights objectAtIndex:inNodeIndex-1]).intValue;
                inNodeString = [longestPaths objectAtIndex:inNodeIndex-1];
            }
            
            int thisWeight = inNodeWeight + i - inNodeIndex;
            if (thisWeight > maxWeight) {
                maxWeight = thisWeight;
                NSString *appendingString = [[searchMatrix objectAtIndex:inNodeIndex] objectAtIndex:i - inNodeIndex];
                pathOfMaxWeight = [inNodeString stringByAppendingString:appendingString];
            }
        }
        
        [weights addObject:@(maxWeight)];          // 记录该点最长路径权值
        [longestPaths addObject:pathOfMaxWeight];  // 记录该点最长路径组成的短句string
    }
    
    return [longestPaths lastObject];
}

// helper
-(NSMutableArray *)makeSearchMatrix:(NSArray *)pinyinNumbers{
    NSMutableArray *searchMatrix = NSMutableArray.new;
    NSInteger count = pinyinNumbers.count;
    for (int i=0; i<count; i++) {
        // make column array
        NSMutableArray *columnArray = [pinyinForest getSearchMatrixColumnForPinyinNumbers:[pinyinNumbers subarrayWithRange:NSMakeRange(i, pinyinNumbers.count-i)]];
        
        [searchMatrix addObject:columnArray];
//        AIBPinyinNode *rootNode = [pinyinForest findNodeOfPinyinNumbers:[pinyinNumbers subarrayWithRange:NSMakeRange(1, pinyinNumbers.count)]  ByOffset:rootOffset];
        
    }
    return searchMatrix;
}

// helper
-(NSMutableArray *)makeInDegreeArrayBySearchMatrix:(NSMutableArray *)searchMatrix{
    NSMutableArray *inDegreeArray = NSMutableArray.new;
    for (int i=0; i<searchMatrix.count; i++) {
        NSMutableArray *subArray = NSMutableArray.new; // each subarray records the in-nodes of this node
        [inDegreeArray addObject:subArray];
    }
    
    for (int i=0; i<searchMatrix.count; i++) {
        NSArray *column = [searchMatrix objectAtIndex:i];
        for (NSString *word in column) {
            if (word.length <= 1) {
                continue;
            }
            NSMutableArray *subArray = [inDegreeArray objectAtIndex: i+word.length-1];
            [subArray addObject:@(i)];
        }
    }
    return  inDegreeArray;
}

@end

