//
//  AIBPinyinRoot.m
//  aeviou_ios_backend
//
//  Created by Air on 3/29/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBPinyinRoot.h"
#import "AIBOffsetReader.h"

@implementation AIBPinyinRoot{
    NSData *prootData;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        // load proot lib file
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"proot"
                                                             ofType:@"jpg"];
        prootData = [NSData dataWithContentsOfFile:filePath];
    }
    return self;
}

-(int)getOffsetOfPinyinNumber:(int)number{
//    NSRange range = {4*number,4};
//    NSData *offsetData = [prootData subdataWithRange:range];
//    return CFSwapInt32BigToHost(*((int*)(offsetData.bytes)));
    return [AIBOffsetReader readIntAtOffset:4*number ofSize:4 inBigEndian:YES ofData:prootData];
}

@end
