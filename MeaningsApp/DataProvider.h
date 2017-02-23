//
//  DataProvider.h
//  MeaningsApp
//
//  Created by Amol Gaikwad on 2/23/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"

@interface DataProvider : NSObject

+(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *))completionHandler;

@end
