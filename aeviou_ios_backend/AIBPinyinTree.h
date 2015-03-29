//
//  AIBPinyinTree.h
//  aeviou_ios_backend
//
//  Created by Air on 3/28/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIBPinyinTree : NSObject

-(instancetype)init;

-(int)getNumberOfPinyin:(NSString *)pinyin; // return the associated number of a pinyin (-1 if not found)


@end


@interface AIBPinyinTreeNode :NSObject

@property (nonatomic) BOOL isPinyin; // see if the pinyin string constructed by characters from root to this node is a valid pinyin
@property (nonatomic) char character; // character of this node
@property (nonatomic,strong) NSMutableArray *childNodes; // child nodes


@end