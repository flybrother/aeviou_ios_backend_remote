//
//  AIBOffsetReader.h
//  aeviou_ios_backend
//
//  Created by Air on 4/12/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIBOffsetReader : NSObject

+ (int)readIntAtOffset:(int)offset ofSize:(int)size inBigEndian:(BOOL)isBigEndian ofData:(NSData *)data;

@end
