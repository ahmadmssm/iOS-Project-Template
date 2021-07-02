//
//  CollectionViewDiffableDataSource.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 21/06/2021.
//

import UIKit
import SkeletonView

open class CollectionViewDiffableDataSource<S: Hashable, T: DiffableItem>: UICollectionViewDiffableDataSource<S, T>, SkeletonCollectionViewDataSource {
    
    public typealias ShimmingProvider = (IndexPath) -> String

    private let shimmingProvider: ShimmingProvider
    
    public init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<S, T>.CellProvider, shimmingProvider: @escaping ShimmingProvider) {
        self.shimmingProvider = shimmingProvider
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        self.shimmingProvider(indexPath)
    }
}
