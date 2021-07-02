//
//  CollectionViewAdapter.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 14/03/2021.
//

import UIKit

open class CollectionViewAdapter: NSObject, UICollectionViewDelegate {
    
    let collectionView: UICollectionView
    var indexPathsForVisibleItems: [IndexPath] {
        self.collectionView.indexPathsForVisibleItems
    }
    private(set) var visibleRect = CGRect()
    private(set) var visiblePoint = CGPoint()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.delegate = self
        self.configureCollectionView()
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.visibleRect.origin = self.collectionView.contentOffset
        self.visibleRect.size = self.collectionView.bounds.size
        self.visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    }
    
    open func configureCollectionView() {}
    
    open func scrollToLastKnownPosition(animated: Bool) {
        self.collectionView.scrollRectToVisible(self.visibleRect, animated: animated)
    }
} 
