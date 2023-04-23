//
//  ClosurePredictionCancellable.swift
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

import Foundation
import CameLLM

public struct ClosurePredictionCancellable: PredictionCancellable {
  public typealias CancelHandler = () -> Void

  let cancelHandler: CancelHandler

  public init(cancelHandler: @escaping CancelHandler) {
    self.cancelHandler = cancelHandler
  }

  public func cancel() {
    cancelHandler()
  }
}
