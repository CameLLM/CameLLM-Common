//
//  CameLLMSessionEvent.mm
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import "CameLLMSessionEvent.h"

typedef NS_ENUM(NSUInteger, CameLLMSessionEventType) {
  CameLLMSessionEventTypeNone = 0,
  CameLLMSessionEventTypeStartedLoadingModel,
  CameLLMSessionEventTypeFinishedLoadingModel,
  CameLLMSessionEventTypeStartedGeneratingOutput,
  CameLLMSessionEventTypeOutputToken,
  CameLLMSessionEventTypeCompleted,
  CameLLMSessionEventTypeFailed,
};

typedef struct {
  NSString *outputToken_token;
  NSError *failed_error;
} CameLLMSessionEventData;

@interface _CameLLMSessionEvent () {
  CameLLMSessionEventType _eventType;
  CameLLMSessionEventData _data;
}

- (instancetype)initWithEventType:(CameLLMSessionEventType)eventType data:(CameLLMSessionEventData)data;

@end

@implementation _CameLLMSessionEvent

- (instancetype)initWithEventType:(CameLLMSessionEventType)eventType data:(CameLLMSessionEventData)data
{
  if ((self = [super init])) {
    _eventType = eventType;
    _data = data;
  }

  return self;
}

+ (instancetype)startedLoadingModel
{
  CameLLMSessionEventData data;
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeStartedLoadingModel data:{}];
}

+ (instancetype)finishedLoadingModel
{
  CameLLMSessionEventData data;
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeFinishedLoadingModel data:{}];
}

+ (instancetype)startedGeneratingOutput
{
  CameLLMSessionEventData data;
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeStartedGeneratingOutput data:{}];
}

+ (instancetype)outputTokenWithToken:(nonnull NSString *)token
{
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeOutputToken data:{ .outputToken_token = [token copy] }];
}

+ (instancetype)completed
{
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeCompleted data:{}];
}

+ (instancetype)failedWithError:(nonnull NSError *)error
{
  return [[_CameLLMSessionEvent alloc] initWithEventType:CameLLMSessionEventTypeFailed data:{ .failed_error = [error copy] }];
}

- (void)matchWithStartedLoadingModel:(void (^)(void))startedLoadingModel
                finishedLoadingModel:(void (^)(void))finishedLoadingModel
             startedGeneratingOutput:(void (^)(void))startedGeneratingOutput
                         outputToken:(void (^)(NSString *token))outputToken
                           completed:(void (^)(void))completed
                              failed:(void (^)(NSError *error))failed
{
  switch (_eventType) {
    case CameLLMSessionEventTypeNone:
      break;
    case CameLLMSessionEventTypeStartedLoadingModel:
      startedLoadingModel();
      break;
    case CameLLMSessionEventTypeFinishedLoadingModel:
      finishedLoadingModel();
      break;
    case CameLLMSessionEventTypeStartedGeneratingOutput:
      startedGeneratingOutput();
      break;
    case CameLLMSessionEventTypeOutputToken:
      outputToken(_data.outputToken_token);
      break;
    case CameLLMSessionEventTypeCompleted:
      completed();
      break;
    case CameLLMSessionEventTypeFailed:
      failed(_data.failed_error);
      break;
  }
}

@end
