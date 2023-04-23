//
//  CameLLMPredictionEvent.mm
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

@import CameLLMObjCxx;

#import "CameLLMPredictionEvent.h"

typedef NS_ENUM(NSUInteger, CameLLMPredictionEventType) {
  CameLLMPredictionEventTypeNone = 0,
  CameLLMPredictionEventTypeStarted,
  CameLLMPredictionEventTypeOutputToken,
  CameLLMPredictionEventTypeUpdatedSessionContext,
  CameLLMPredictionEventTypeCompleted,
  CameLLMPredictionEventTypeCancelled,
  CameLLMPredictionEventTypeFailed,
};

typedef struct CameLLMPredictionEventData {
  _SessionContext *updatedSessionContext_context;
  NSString *outputToken_token;
  NSError *failed_error;
} CameLLMPredictionEventData;

@interface _CameLLMPredictionEvent () {
  CameLLMPredictionEventType _eventType;
  CameLLMPredictionEventData _data;
}

- (instancetype)initWithEventType:(CameLLMPredictionEventType)eventType data:(CameLLMPredictionEventData)data;

@end

@implementation _CameLLMPredictionEvent

- (instancetype)initWithEventType:(CameLLMPredictionEventType)eventType data:(CameLLMPredictionEventData)data
{
  if ((self = [super init])) {
    _eventType = eventType;
    _data = data;
  }

  return self;
}

+ (instancetype)started
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeStarted
                                                     data:{}];
}

+ (instancetype)outputTokenWithToken:(nonnull NSString *)token
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeOutputToken
                                                     data:{ .outputToken_token = [token copy] }];
}

+ (instancetype)updatedSessionContext:(id)sessionContext
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeUpdatedSessionContext
                                                     data:{ .updatedSessionContext_context = [sessionContext copy] }];
}

+ (instancetype)completed
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeCompleted
                                                     data:{}];
}

+ (instancetype)cancelled
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeCancelled
                                                     data:{}];
}

+ (instancetype)failedWithError:(nonnull NSError *)error
{
  return [[_CameLLMPredictionEvent alloc] initWithEventType:CameLLMPredictionEventTypeFailed
                                                     data:{ .failed_error = [error copy] }];
}

- (void)matchStarted:(void (NS_NOESCAPE ^)(void))started
         outputToken:(void (NS_NOESCAPE ^)(NSString *token))outputToken
updatedSessionContext:(void (NS_NOESCAPE ^)(_SessionContext *sessionContext))updatedSessionContext
           completed:(void (NS_NOESCAPE ^)(void))completed
           cancelled:(void (NS_NOESCAPE ^)(void))cancelled
              failed:(void (NS_NOESCAPE ^)(NSError *error))failed
{
  switch (_eventType) {
    case CameLLMPredictionEventTypeNone:
      break;
    case CameLLMPredictionEventTypeStarted:
      started();
      break;
    case CameLLMPredictionEventTypeOutputToken:
      outputToken(_data.outputToken_token);
      break;
    case CameLLMPredictionEventTypeUpdatedSessionContext:
      if (_data.updatedSessionContext_context) {
        updatedSessionContext(_data.updatedSessionContext_context);
      } else {
        NSLog(@"Warning: missing UpdatedSessionContext data in _CameLLMPredictionEvent");
      }
      break;
    case CameLLMPredictionEventTypeCompleted:
      completed();
      break;
    case CameLLMPredictionEventTypeCancelled:
      cancelled();
      break;
    case CameLLMPredictionEventTypeFailed:
      failed(_data.failed_error);
      break;
  }
}

@end
