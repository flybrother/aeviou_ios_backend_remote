//
//  AIBPinyinForest.m
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBPinyinForest.h"
#import "AIBOffsetReader.h"
#import "AIBPinyinNode.h"

@implementation AIBPinyinForest{
    NSData *pForestData;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        // load pnode lib file
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"pnode"
                                                             ofType:@"jpg"];
        pForestData = [NSData dataWithContentsOfFile:filePath];
    }
    return self;
}


// get node info at offset in pinyin forest
-(AIBPinyinNode *)getNodeByOffset:(int)offset{
    AIBPinyinNode *node = [[AIBPinyinNode alloc] init];
    node.pinyinNumber = [AIBOffsetReader readIntAtOffset:offset ofSize:2 inBigEndian:YES ofData:pForestData];
    node.offsetInPHanzi = [AIBOffsetReader readIntAtOffset:offset+2 ofSize:4 inBigEndian:YES ofData:pForestData];
    node.maxFrequency = [AIBOffsetReader readIntAtOffset:offset+6 ofSize:4 inBigEndian:YES ofData:pForestData];
    node.childrenSize = [AIBOffsetReader readIntAtOffset:offset+10 ofSize:2 inBigEndian:YES ofData:pForestData];
    node.childrenOffsetInPNode = [AIBOffsetReader readIntAtOffset:offset+12 ofSize:4 inBigEndian:YES ofData:pForestData];
    return node;
}

// use binary search to search a possible child node with given pinyinNumber in children nodes start from offset
// return nil if can't be found
-(AIBPinyinNode *)searchPinyinNumber:(int)pinyinNumber inChildrenOf:(AIBPinyinNode *)parentNode{
    // compose array made up of children pinyin numbers
    NSMutableArray *childrenPinyinNumbers = NSMutableArray.new;
    for (int i=0; i<parentNode.childrenSize; i++) {
        int pinyinNumberX = [AIBOffsetReader readIntAtOffset:parentNode.childrenOffsetInPNode+16*i ofSize:2 inBigEndian:YES ofData:pForestData];
        [childrenPinyinNumbers addObject:@(pinyinNumberX)];
    }
    
    // binary search
//    pinyinNumber = 11;
    int targetIndex = [self binarySearch:pinyinNumber In:childrenPinyinNumbers With:0 And:childrenPinyinNumbers.count-1];
    if (targetIndex == -1) {
        return nil;
    } else {
        AIBPinyinNode *targetNode = [[AIBPinyinNode alloc] init];
        targetNode = [self getNodeByOffset:parentNode.childrenOffsetInPNode+16*targetIndex];
        return targetNode;
    }
    return nil;
}

// helper
// binary search
// return target index
// or -1 if not found
-(int)binarySearch:(int)target In:(NSMutableArray *)array With:(int)lower And:(int)upper{
    if (lower == upper) {
        if (target == ((NSNumber *)[array objectAtIndex:lower]).intValue) { // find the target
            return lower;
        } else {
            return -1;
        }
    }
    int mid = lower + (upper - lower)/2;
    int midValue = ((NSNumber *)[array objectAtIndex:mid]).intValue;
    if (target < midValue) {
        return [self binarySearch:target In:array With:lower And:mid];
    } else if (target > midValue){
        return [self binarySearch:target In:array With:mid+1 And:upper];
    } else {
        return mid;
    }
}

-(AIBPinyinNode *)findNodeOfPinyinNumbers:(NSArray *)pinyinNumbers ByOffset:(int)offset{
//    int currentOffset = offset;
    AIBPinyinNode *currentNode = [[AIBPinyinNode alloc] init];
    currentNode = [self getNodeByOffset:offset];
    for (int i=0; i<pinyinNumbers.count; i++) {
        currentNode = [self searchPinyinNumber:((NSNumber *)[pinyinNumbers objectAtIndex:i]).intValue inChildrenOf:currentNode];
        if (!currentNode) {
            return nil;
        }
    }
    return currentNode;
}


@end

