//
//  AIBPinyinHanzi.m
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBPinyinHanzi.h"
#import "AIBOffsetReader.h"

@implementation AIBPinyinHanzi{
    NSData *pHanziData;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        // load pnode lib file
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"phanzi"
                                                             ofType:@"jpg"];
        pHanziData = [NSData dataWithContentsOfFile:filePath];
    }
    return self;
}

-(NSMutableArray *)getHanziArrayAtOffset:(int)offset{
    int pinyinLength = [AIBOffsetReader readIntAtOffset:offset ofSize:2 inBigEndian:YES ofData:pHanziData];
    int hanziLength = [AIBOffsetReader readIntAtOffset:offset+2 ofSize:2 inBigEndian:YES ofData:pHanziData];
    NSMutableArray *hanziArray = NSMutableArray.new;
    for (int i=0; i<hanziLength; i++) {
        NSString *hanzi = [AIBOffsetReader readPinyinAtOffset:offset+4+i*(2*pinyinLength+4) ofSize:2*pinyinLength inBigEndian:YES ofData:pHanziData];
        int freq = [AIBOffsetReader readIntAtOffset:offset+4+i*(2*pinyinLength+4)+2*pinyinLength ofSize:4 inBigEndian:YES ofData:pHanziData];
        [hanziArray addObject:hanzi];
    }

    return hanziArray;
}


@end
