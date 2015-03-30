//
//  AIBPinyinTree.m
//  aeviou_ios_backend
//
//  Created by Air on 3/28/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "AIBPinyinTree.h"
#import "DDFileReader.h"
#import "malloc/malloc.h"

@implementation AIBPinyinTree{
    NSMutableDictionary *pinyinDict;
}

#define BUFFER_LEN 10

-(instancetype)init{
    self = [super init];
    if (self) {
        pinyinDict = NSMutableDictionary.new;
        
        // load "pinyin_list"
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"pinyin_list"
                                                             ofType:@""];
        DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:filePath];
        __block NSNumber *i = [[NSNumber alloc] initWithInt:0];
        [reader enumerateLinesUsingBlock:^(NSString * line, BOOL * stop) {
//            NSLog(@"read line %d: %@", i,line);
            char *line_c = [line cStringUsingEncoding:NSUTF8StringEncoding];
            char pinyin_c[10],sheng[10],yun[10];
            sscanf(line_c, "%s %s %s",pinyin_c,sheng,yun);
            NSString *pinyin = [NSString stringWithUTF8String:pinyin_c];
            if ([[pinyin substringToIndex:1] isEqualToString:@"'"]) {
                pinyin = [pinyin substringFromIndex:1];
            }
//            NSLog(@"%@ %s %s",pinyin,sheng,yun);
            [pinyinDict setObject:i forKey:pinyin];
            i = [NSNumber numberWithInt:[i intValue]+1];
        }];
        
//        NSLog(@"dict size:%zd",malloc_size((__bridge const void *)(pinyinDict)));
    }
    return self;
}

-(int)getNumberOfPinyin:(NSString *)pinyin{
    NSNumber *number = [pinyinDict valueForKey:pinyin];
    if (number) {
        return [number intValue];
    }
    return -1;
}


@end
