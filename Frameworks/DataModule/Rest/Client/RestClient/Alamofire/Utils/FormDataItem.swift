//
//  FormDataItem.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 19/02/2021.
//

import Foundation

public struct FormDataItem {

    let data: Data
    let name: String
    let fileName: String?
    let mimeType: String?
    
    init(data: Data, name: String, fileName: String?, mimeType: String?) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
