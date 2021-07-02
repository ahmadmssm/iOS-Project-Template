//
//  DiffableCollectionViewAdapter.swift
//  AppCoreFeatures
//
//  Created by Ahmad Mahmoud on 21/06/2021.
//

import UIKit

open class DiffableCollectionViewAdapter<Sections: DiffableSection, ItemType: DiffableItem>: NSObject, UICollectionViewDelegate {
    
    let collectionView: UICollectionView
    private(set) var visibleRect = CGRect()
    private(set) var visiblePoint = CGPoint()
    private(set) lazy var snapshot = DiffableCollectionViewSnapshot<Sections, ItemType>()
    private(set) lazy var diffableDataSource: CollectionViewDiffableDataSource = {
        return CollectionViewDiffableDataSource<Sections, ItemType>(collectionView: self.collectionView) { _, indexPath, item in
            return self.createCell(for: indexPath, item: item)
        } shimmingProvider: { indexPath in
            return self.getCellIdentifier(at: indexPath)
        }
    }()

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.delegate = self
        self.configureCollectionView()
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.visibleRect.origin = self.collectionView.contentOffset
        self.visibleRect.size = self.collectionView.bounds.size
        self.visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    }
    
    func post(items: [ItemType], toSection section: Sections, animate: Bool = false) {
        self.snapshot.appendItems(items, toSection: section)
        diffableDataSource.apply(self.snapshot, animatingDifferences: true)
    }
    
    open func delete(sections: Sections...) {
        self.snapshot.deleteSections(sections)
        self.diffableDataSource.apply(self.snapshot)
    }
    
    func scrollToLastKnownPosition(animated: Bool) {
        self.collectionView.scrollRectToVisible(self.visibleRect, animated: animated)
    }
    
    open func configureCollectionView() {}
    
    open func createCell(for indexPath: IndexPath, item: ItemType) -> UICollectionViewCell {
        fatalError("Not Implemented")
    }
    
    open func getCellIdentifier(at indexPath: IndexPath) -> String {
        fatalError("Not Implemented")
    }
}
