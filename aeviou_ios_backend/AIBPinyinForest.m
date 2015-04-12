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

-(AIBPinyinNode *)getNodeByOffset:(int)offset{
    AIBPinyinNode *node = [[AIBPinyinNode alloc] init];
    node.pinyinNumber = [AIBOffsetReader readIntAtOffset:offset ofSize:2 inBigEndian:YES ofData:pForestData];
    node.offsetInPHanzi = [AIBOffsetReader readIntAtOffset:offset+2 ofSize:4 inBigEndian:YES ofData:pForestData];
    node.maxFrequency = [AIBOffsetReader readIntAtOffset:offset+6 ofSize:4 inBigEndian:YES ofData:pForestData];
    node.childrenSize = [AIBOffsetReader readIntAtOffset:offset+10 ofSize:2 inBigEndian:YES ofData:pForestData];
    node.childrenOffsetInPNode = [AIBOffsetReader readIntAtOffset:offset+12 ofSize:4 inBigEndian:YES ofData:pForestData];
    return node;
}



@end

