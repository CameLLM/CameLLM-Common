//
//  CameLLMPredictionEvent.h
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import <Foundation/Foundation.h>

@class _SessionContext;

NS_ASSUME_NONNULL_BEGIN

@interface _CameLLMPredictionEvent : NSObject

+ (instancetype)started;
+ (instancetype)outputTokenWithToken:(nonnull NSString *)token;
+ (instancetype)updatedSessionContext:(_SessionContext *)sessionContext;
+ (instancetype)completed;
+ (instancetype)cancelled;
+ (instancetype)failedWithError:(nonnull NSError *)error;

- (void)matchStarted:(void (NS_NOESCAPE ^)(void))started
         outputToken:(void (NS_NOESCAPE ^)(NSString *token))outputToken
updatedSessionContext:(void (NS_NOESCAPE ^)(_SessionContext *))updatedSessionContext
           completed:(void (NS_NOESCAPE ^)(void))completed
           cancelled:(void (NS_NOESCAPE ^)(void))cancelled
              failed:(void (NS_NOESCAPE ^)(NSError *__nullable error))failed;

@end

NS_ASSUME_NONNULL_END
