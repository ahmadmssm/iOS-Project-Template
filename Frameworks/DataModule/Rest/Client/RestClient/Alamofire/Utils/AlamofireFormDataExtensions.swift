//
//  AlamofireFormDataExtensions.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Alamofire
import Foundation

public extension Dictionary where Key == String {
    func toMultipartFormData() -> MultipartFormData {
        let formData = MultipartFormData()
        formData.from(dictionary: self)
        return formData
    }
}

public extension MultipartFormData {
    
    func from(dictionary: [String: Any]) {
        for (key, value) in dictionary {
            self.append(value: value, withKey: key)
            if let arrayValue = value as? NSArray {
                arrayValue.forEach({ element in
                    let formKey = key + "[]"
                    self.append(value: element, withKey: formKey)
                })
            }
        }
    }
    
    private func append(value: Any, withKey key: String) {
        if let string = value as? String {
            self.append(string.data(using: .utf8)!, withName: key)
        }
        if let int = value as? Int {
            self.append("\(int)".data(using: .utf8)!, withName: key)
        }
        if let double = value as? Double {
            self.append("\(double)".data(using: .utf8)!, withName: key)
        }
        if let float = value as? Float {
            self.append("\(float)".data(using: .utf8)!, withName: key)
        }
        if let boolean = value as? Bool {
            self.append(String(boolean).data(using: .utf8)!, withName: key)
        }
        if let file = value as? FormDataItem {
            self.append(file: file)
        }
    }
    
    private func append(file: FormDataItem) {
        self.append(file.data,
                    withName: file.name,
                    fileName: file.fileName,
                    mimeType: file.mimeType)
    }
}
