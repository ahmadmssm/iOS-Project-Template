//
//  CompositionalLayoutBuilder.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 14/03/2021.
//

import UIKit

public class CompositionalLayoutBuilder {
    
    public class Group {
        
        private var itemWidth: NSCollectionLayoutDimension = .estimated(1)
        private var itemHeight: NSCollectionLayoutDimension = .estimated(1)
        private var groupWidth: NSCollectionLayoutDimension = .estimated(1)
        private var groupHeight: NSCollectionLayoutDimension = .estimated(1)
        private var itemSize: NSCollectionLayoutSize {
            return NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        }
        private var groupItem: NSCollectionLayoutItem {
            return NSCollectionLayoutItem(layoutSize: itemSize)
        }
        private var groupSize: NSCollectionLayoutSize {
            return NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        }
        
        public init() {}
        
        public func setGroupItemWidth(_ width: NSCollectionLayoutDimension) -> Group {
            self.itemWidth = width
            return self
        }
        
        public func setGroupItemHeight(_ height: NSCollectionLayoutDimension) -> Group {
            self.itemHeight = height
            return self
        }
        
        public func setGroupWidth(_ width: NSCollectionLayoutDimension) -> Group {
            self.groupWidth = width
            return self
        }
        
        public func setGroupHeight(_ height: NSCollectionLayoutDimension) -> Group {
            self.groupHeight = height
            return self
        }
        
        @discardableResult
        public func createVerticalGroup() -> NSCollectionLayoutGroup {
            return NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [groupItem])
        }
        
        @discardableResult
        public func createHorizontalGroup() -> NSCollectionLayoutGroup {
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [groupItem])
        }
        
        @discardableResult
        public func createHorizontalGroup(numberOfItems: Int) -> NSCollectionLayoutGroup {
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                      subitem: groupItem,
                                                      count: numberOfItems)
        }
    }
}
