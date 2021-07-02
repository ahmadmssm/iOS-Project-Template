//
//  SwiftEventBus.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 06/06/2021.
//

import Foundation

public class SwiftEventBus {
    
    private static let notificationCenter = NotificationCenter.default
    
    public static func postEvent(withKey key: String) {
        let name = self.createNotificationName(key: key)
        notificationCenter.post(name: name, object: nil)
    }
    
    public static func post<T>(obj: T, forKey key: String) {
        let userInfo = [key: obj]
        let name = self.createNotificationName(key: key)
        notificationCenter.post(name: name, object: nil, userInfo: userInfo)
    }
    
    public static func observe<T>(forKey key: String,
                                  queue: OperationQueue? = OperationQueue.main,
                                  object: Any?,
                                  block: @escaping (T?) -> Void) -> NSObjectProtocol {
        let name = self.createNotificationName(key: key)
        return notificationCenter.addObserver(forName: name,
                                              object: object,
                                              queue: queue) { notification in
            let object = notification.userInfo?[name] as? T
            block(object)
        }
    }
    
    public static func observeEvent(withKey key: String,
                                    queue: OperationQueue? = OperationQueue.main,
                                    object: Any?,
                                    block: @escaping () -> Void) -> NSObjectProtocol {
        let name = self.createNotificationName(key: key)
        return notificationCenter.addObserver(forName: name, object: object, queue: queue) { _ in
            block()
        }
    }
    
    public static func remove(_ observer: NSObjectProtocol) {
        notificationCenter.removeObserver(observer)
    }
    
    private static func createNotificationName(key: String) -> Notification.Name {
        return Notification.Name(key)
    }
}
