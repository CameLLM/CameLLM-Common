//
//  CameLLMSessionEvent.h
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _CameLLMSessionEvent : NSObject

+ (instancetype)startedLoadingModel;
+ (instancetype)finishedLoadingModel;
+ (instancetype)startedGeneratingOutput;
+ (instancetype)outputTokenWithToken:(nonnull NSString *)token;
+ (instancetype)completed;
+ (instancetype)failedWithError:(nonnull NSError *)error;

- (void)matchWithStartedLoadingModel:(void (^)(void))startedLoadingModel
                finishedLoadingModel:(void (^)(void))finishedLoadingModel
             startedGeneratingOutput:(void (^)(void))startedGeneratingOutput
                         outputToken:(void (^)(NSString *token))startedLoadingModel
                           completed:(void (^)(void))startedLoadingModel
                              failed:(void (^)(NSError *error))startedLoadingModel;

@end

NS_ASSUME_NONNULL_END
