//
//  UICollectionView+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 01/03/2021.
//

import UIKit

public extension UICollectionView {
    
    func reloadItems(inSection section: Int) {
        reloadItems(at: (0..<numberOfItems(inSection: section)).map {
            IndexPath(item: $0, section: section)
        })
    }
    
    func makeDataSource<S: Hashable, T: Hashable, C: UICollectionViewCell & ReusableCell>(cell: C.Type, block: @escaping (C, IndexPath, T) -> Void) -> UICollectionViewDiffableDataSource<S, T> {
        return UICollectionViewDiffableDataSource<S, T>(collectionView: self, cellProvider: { (collectionView, indexPath, item) -> C? in
            let cell: C = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            block(cell, indexPath, item)
            return cell
        })
    }
    
    func registerCell<T: UICollectionViewCell>(cellClass: T.Type) where T: ReusableCell {
        let bundle = Bundle(for: cellClass.self)
        let cellClassName: String = String(describing: cellClass.self)
        let nib = UINib(nibName: cellClassName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: cellClassName)
    }
    
    func registerHeaderCell<T: UICollectionReusableView>(headerClass: T.Type) where T: ReusableCell {
        let nibName = NSStringFromClass(T.self).components(separatedBy: ".").last!
        register(headerClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName)
    }
    
    func registerFooterCell<T: UICollectionViewCell>(footerClass: T.Type) where T: ReusableCell {
        let bundle = Bundle(for: footerClass.self)
        let nibName = NSStringFromClass(T.self).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibName)
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(viewClass: T.Type) where T: ReusableCell {
        let bundle = Bundle(for: viewClass.self)
        let nibName = NSStringFromClass(T.self).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: nibName, withReuseIdentifier: nibName)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.dequeueIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderCell<H: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> H where H: ReusableCell {
        return dequeueReusableHeaderOrFooterCell(kind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
    }
    
    func dequeueReusableFooterCell<F: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> F where F: ReusableCell {
        return dequeueReusableHeaderOrFooterCell(kind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
    }
    
    func dequeueReusableDefaultCell(indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView & ReusableCell>(for indexPath: IndexPath) -> T? {
        let className = T.className
        return dequeueReusableSupplementaryView(ofKind: className, withReuseIdentifier: className,
                                                for: indexPath) as? T
    }
    
    private func dequeueReusableHeaderOrFooterCell <T: UICollectionReusableView>
        (kind: String, forIndexPath indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.dequeueIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
}
