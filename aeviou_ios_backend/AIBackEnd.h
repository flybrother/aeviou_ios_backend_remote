//
//  AIBackEnd.h
//  aeviou_ios_backend
//
//  Created by Air on 3/28/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AIBackEnd : NSObject

-(NSMutableArray *)getHanziArrayByPinyin:(NSArray *)pinyins;

@end
