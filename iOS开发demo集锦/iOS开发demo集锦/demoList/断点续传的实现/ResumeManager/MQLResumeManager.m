//
//  MQLResumeManager.m
//  URLSessionTest
//
//  Created by 马千里 on 15/10/21.
//  Copyright © 2015年 MQL. All rights reserved.
//

#import "MQLResumeManager.h"

typedef void (^completionBlock)();
typedef void (^progressBlock)();

@interface MQLResumeManager ()<NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession *session;    //注意一个session只能有一个请求任务
@property(nonatomic, readwrite, retain) NSError *error; //请求出错
@property(nonatomic, readwrite, copy) completionBlock completionBlock;
@property(nonatomic, readwrite, copy) progressBlock progressBlock;

@property (nonatomic, strong) NSURL *url;           //文件资源地址
@property (nonatomic, strong) NSString *targetPath; //文件存放路径
@property long long totalContentLength;             //文件总大小
@property long long totalReceivedContentLength;     //已下载大小

/**
 *  设置成功、失败回调block
 *
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
- (void)setCompletionBlockWithSuccess:(void (^)())success
                              failure:(void (^)(NSError *error))failure;

/**
 *  设置进度回调block
 *
 *  @param progress
 */
-(void)setProgressBlockWithProgress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress;

/**
 *  获取文件大小
 *  @param path 文件路径
 *  @return 文件大小
 *
 */
- (long long)fileSizeForPath:(NSString *)path;

@end

@implementation MQLResumeManager

/**
 *  设置成功、失败回调block
 *
 *  @param success 成功回调block
 *  @param failure 失败回调block
 */
- (void)setCompletionBlockWithSuccess:(void (^)())success
                              failure:(void (^)(NSError *error))failure{
    
    __weak typeof(self) weakSelf = self;
    self.completionBlock = ^ {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (weakSelf.error) {
                if (failure) {
                    failure(weakSelf.error);
                }
            } else {
                if (success) {
                    success();
                }
            }
            
        });
    };
}

/**
 *  设置进度回调block
 *
 *  @param progress
 */
-(void)setProgressBlockWithProgress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress{
    
    __weak typeof(self) weakSelf = self;
    self.progressBlock = ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            progress(weakSelf.totalReceivedContentLength, weakSelf.totalContentLength);
        });
    };
}

/**
 *  获取文件大小
 *  @param path 文件路径
 *  @return 文件大小
 *
 */
- (long long)fileSizeForPath:(NSString *)path {
    
    long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

/**
 *  创建断点续传管理对象，启动下载请求
 *
 *  @param url          文件资源地址
 *  @param targetPath   文件存放路径
 *  @param success      文件下载成功的回调块
 *  @param failure      文件下载失败的回调块
 *  @param progress     文件下载进度的回调块
 *
 *  @return 断点续传管理对象
 *
 */
+(MQLResumeManager*)resumeManagerWithURL:(NSURL*)url
                              targetPath:(NSString*)targetPath
                                 success:(void (^)())success
                                 failure:(void (^)(NSError *error))failure
                                progress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress{
    
    MQLResumeManager *manager = [[MQLResumeManager alloc]init];
    
    manager.url = url;
    manager.targetPath = targetPath;
    [manager setCompletionBlockWithSuccess:success failure:failure];
    [manager setProgressBlockWithProgress:progress];
    
    manager.totalContentLength = 0;
    manager.totalReceivedContentLength = 0;
    
    return manager;
}

/**
 *  启动断点续传下载请求
 */
-(void)start{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:self.url];
    
    long long downloadedBytes = self.totalReceivedContentLength = [self fileSizeForPath:self.targetPath];
    if (downloadedBytes > 0) {
        
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
        [request setValue:requestRange forHTTPHeaderField:@"Range"];
    }else{
        
        int fileDescriptor = open([self.targetPath UTF8String], O_CREAT | O_EXCL | O_RDWR, 0666);
        if (fileDescriptor > 0) {
            close(fileDescriptor);
        }
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:queue];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
    [dataTask resume];
}

/**
 *  取消断点续传下载请求
 */
-(void)cancel{
    
    if (self.session) {
        
        [self.session invalidateAndCancel];
        self.session = nil;
    }
}

#pragma mark -- NSURLSessionDelegate
/* The last message a session delegate receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error{
    
    NSLog(@"didBecomeInvalidWithError");
}

#pragma mark -- NSURLSessionTaskDelegate
/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
    NSLog(@"didCompleteWithError");
    
    if (error == nil && self.error == nil) {
        
        self.completionBlock();
        
    }else if (error != nil){
        
        if (error.code != -999) {
            
            self.error = error;
            self.completionBlock();
        }
        
    }else if (self.error != nil){
        
        self.completionBlock();
    }
    
    
}

#pragma mark -- NSURLSessionDataDelegate
/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
    //根据status code的不同，做相应的处理
    NSHTTPURLResponse *response = (NSHTTPURLResponse*)dataTask.response;
    if (response.statusCode == 200) {
        
        self.totalContentLength = dataTask.countOfBytesExpectedToReceive;
        
    }else if (response.statusCode == 206){
        
        NSString *contentRange = [response.allHeaderFields valueForKey:@"Content-Range"];
        if ([contentRange hasPrefix:@"bytes"]) {
            NSArray *bytes = [contentRange componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -/"]];
            if ([bytes count] == 4) {
                self.totalContentLength = [[bytes objectAtIndex:3] longLongValue];
            }
        }
    }else if (response.statusCode == 416){
        
        NSString *contentRange = [response.allHeaderFields valueForKey:@"Content-Range"];
        if ([contentRange hasPrefix:@"bytes"]) {
            NSArray *bytes = [contentRange componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -/"]];
            if ([bytes count] == 3) {
                
                self.totalContentLength = [[bytes objectAtIndex:2] longLongValue];
                if (self.totalReceivedContentLength == self.totalContentLength) {
                    
                    //说明已下完
                    
                    //更新进度
                    self.progressBlock();
                }else{
                    
                    //416 Requested Range Not Satisfiable
                    self.error = [[NSError alloc]initWithDomain:[self.url absoluteString] code:416 userInfo:response.allHeaderFields];
                }
            }
        }
        return;
    }else{
        
        //其他情况还没发现
        return;
    }
    
    //向文件追加数据
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:self.targetPath];
    [fileHandle seekToEndOfFile]; //将节点跳到文件的末尾
    
    [fileHandle writeData:data];//追加写入数据
    [fileHandle closeFile];
    
    //更新进度
    self.totalReceivedContentLength += data.length;
    self.progressBlock();
}







@end
