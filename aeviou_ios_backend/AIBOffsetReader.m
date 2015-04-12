//
//  AIBOffsetReader.m
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBOffsetReader.h"

@implementation AIBOffsetReader

+(int)readIntAtOffset:(int)offset ofSize:(int)size inBigEndian:(BOOL)isBigEndian ofData:(NSData *)data{
    NSRange range = {offset,size};
    NSData *offsetData = [data subdataWithRange:range];
    if (isBigEndian) {
        switch (size) {
            case 2:
                return CFSwapInt16BigToHost(*((int*)(offsetData.bytes)));
                break;
            case 4:
                return CFSwapInt32BigToHost(*((int*)(offsetData.bytes)));
            default:
                return -1;
        }
    } else {
        return *((int*)(offsetData.bytes));
    }
}

+(NSString *)readPinyinAtOffset:(int)offset ofSize:(int)size inBigEndian:(BOOL)isBigEndian ofData:(NSData *)data{
    NSRange range = {offset,size};
    NSData *offsetData = [data subdataWithRange:range];
    char *a = malloc(size);
    for (int i=0; i<size; i=i+2) {
        a[i] = ((char*)offsetData.bytes)[i+1];
        a[i+1] = ((char*)offsetData.bytes)[i];
    }
    NSString *ret = [NSString stringWithCharacters:(a) length:size/2];
    free(a);
    return ret;
}

@end
