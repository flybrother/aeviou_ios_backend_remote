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

@implementation AIBackEnd{
    AIBPinyinTree *pinyinTree;
    AIBPinyinRoot *pinyinRoot;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        pinyinTree = [[AIBPinyinTree alloc] init];
        pinyinRoot = [[AIBPinyinRoot alloc] init];
        int ret = -1;
        ret = [pinyinRoot getOffsetOfPinyinNumber:1];
        NSLog(@"ret is %d",ret);
    }
    return self;
}



@end

