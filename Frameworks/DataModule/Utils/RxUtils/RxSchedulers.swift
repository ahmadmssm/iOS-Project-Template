//
//  RxSchedulers.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 24/02/2021.
//

import RxSwift

public struct RxSchedulers {
    public static let mainThread = MainScheduler.instance
    public static let workerThread = ConcurrentDispatchQueueScheduler(qos: .default)
    public static let backgroundConcurrentThread = ConcurrentDispatchQueueScheduler(qos: .background)
    public static var backgroundSerialThread = SerialDispatchQueueScheduler(qos: .background)
}
