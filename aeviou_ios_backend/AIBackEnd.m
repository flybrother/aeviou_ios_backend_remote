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

@implementation AIBackEnd{
    AIBPinyinTree *pinyinTree;
    AIBPinyinRoot *pinyinRoot;
    AIBPinyinForest *pinyinForest;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        pinyinTree = [[AIBPinyinTree alloc] init];
        pinyinRoot = [[AIBPinyinRoot alloc] init];
        pinyinForest = [[AIBPinyinForest alloc] init];
        int ret = -1;
        ret = [pinyinRoot getOffsetOfPinyinNumber:288];
        NSLog(@"ret is %d",ret);
        AIBPinyinNode *node = [pinyinForest getNodeByOffset:ret];
    }
    return self;
}



@end

