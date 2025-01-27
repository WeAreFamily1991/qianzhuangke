//
//  DRCacheDataManager.m
//  Shop
//
//  Created by BWJ on 2019/7/22.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRCacheDataManager.h"

@implementation DRCacheDataManager

+ (nonnull instancetype)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (long long)cacheDataLength {
    
    return [self allCacheDataLength];
}

- (long long) allCacheDataLength {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *downloadURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    downloadURL = [downloadURL URLByAppendingPathComponent:@"mp4"];
    if(![fileManager fileExistsAtPath:downloadURL.path]) {
        [fileManager createDirectoryAtPath:downloadURL.path withIntermediateDirectories:YES attributes:nil error:nil];
        return 0;
    }
    
    return [self folderSizeAtPath:downloadURL.path];
}

//遍历文件夹获得文件夹大小，返回多少M

- (long long) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize;
    
}

//单个文件的大小

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
