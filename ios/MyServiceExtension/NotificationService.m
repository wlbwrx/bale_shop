//
//  NotificationService.m
//  MyServiceExtension
//
//  Created by 王家辉 on 2020/5/26.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    if([self.bestAttemptContent.categoryIdentifier isEqualToString:@"media"])
    {
        //如果远程推送的payload中含有media标识，则表示需要处理多媒体通知，包括图片、音乐、视频
        NSString *mediaUrlStr = [self.bestAttemptContent.userInfo objectForKey:@"mediaUrl"];
        NSURL *mediaUrl = [[NSURL alloc]initWithString:mediaUrlStr];
        
        [self downloadAndSave:mediaUrl handler:^(NSURL *localUrl) {
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:localUrl options:nil error:nil];
            self.bestAttemptContent.attachments = @[attachment];
            self.contentHandler(self.bestAttemptContent);
        }];
    }
    else
    {
        self.contentHandler(self.bestAttemptContent);
    }
}

-(void)downloadAndSave:(NSURL *)url handler: (void (^)(NSURL *localUrl)) handler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // location是沙盒中临时文件夹下的一个临时url,文件下载后会存到这个位置,
        //由于临时目录中的文件随时可能被删除,建议把下载的文件挪到需要的地方
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
        handler([NSURL fileURLWithPath:path]);
    }];
    [task resume];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}



@end
