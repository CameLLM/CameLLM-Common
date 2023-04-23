//
//  CameLLMSetupEvent.h
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _CameLLMSetupEvent<ContextType> : NSObject

+ (instancetype)succeededWithContext:(ContextType)context;
+ (instancetype)failedWithError:(NSError *)error;

- (void)matchSucceeded:(void (NS_NOESCAPE ^)(ContextType))succeeded
                failed:(void (NS_NOESCAPE ^)(NSError *error))failed;

@end

NS_ASSUME_NONNULL_END
