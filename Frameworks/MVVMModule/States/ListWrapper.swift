//
//  ListWrapper.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 01/03/2021.
//

public enum ListWrapper<T> {
    case list([T])
    case reloadListFromScratch(list: [T])
    case emptyList
    case reloadFromScratch
    case noMoreItemsToLoad
}
