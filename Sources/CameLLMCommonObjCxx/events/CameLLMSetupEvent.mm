//
//  CameLLMSetupEvent.mm
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

#import "CameLLMSetupEvent.h"

typedef NS_ENUM(NSUInteger, CameLLMSetupEventType) {
  CameLLMSetupEventTypeNone = 0,
  CameLLMSetupEventTypeSucceeded,
  CameLLMSetupEventTypeFailed,
};

typedef struct {
  id succeeded_context;
  NSError *failed_error;
} CameLLMSetupEventData;

@interface _CameLLMSetupEvent () {
  CameLLMSetupEventType _eventType;
  CameLLMSetupEventData _data;
}

- (instancetype)initWithEventType:(CameLLMSetupEventType)eventType data:(CameLLMSetupEventData)data;

@end

@implementation _CameLLMSetupEvent

- (instancetype)initWithEventType:(CameLLMSetupEventType)eventType data:(CameLLMSetupEventData)data
{
  if ((self = [super init])) {
    _eventType = eventType;
    _data = data;
  }

  return self;
}

+ (instancetype)succeededWithContext:(id)context
{
  return [[_CameLLMSetupEvent alloc] initWithEventType:CameLLMSetupEventTypeSucceeded
                                                     data:{ .succeeded_context = context }];
}

+ (instancetype)failedWithError:(nonnull NSError *)error
{
  return [[_CameLLMSetupEvent alloc] initWithEventType:CameLLMSetupEventTypeFailed
                                                     data:{ .failed_error = [error copy] }];
}

- (void)matchSucceeded:(void (NS_NOESCAPE ^)(id))succeeded
                failed:(void (NS_NOESCAPE ^)(NSError *error))failed
{
  switch (_eventType) {
    case CameLLMSetupEventTypeNone:
      break;
    case CameLLMSetupEventTypeSucceeded:
      succeeded(_data.succeeded_context);
      break;
    case CameLLMSetupEventTypeFailed:
      failed(_data.failed_error);
      break;
  }
}

@end
