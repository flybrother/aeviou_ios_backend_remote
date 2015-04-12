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

@end

