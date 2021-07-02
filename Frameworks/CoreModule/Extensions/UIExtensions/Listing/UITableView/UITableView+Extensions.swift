//
//  UITableView+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 21/03/2021.
//

import UIKit

// MARK: - Table View Registration and Dequeue
public extension UITableView {
    /// Register a cell withOut xib into a table instance.
    ///
    /// - Parameter _: cell class
    func register<T: UITableViewCell>(cellClass: T.Type) where T: ReusableCell {
        self.register(cellClass.self, forCellReuseIdentifier: cellClass.dequeueNibName)
    }
    
    /// Register a cell from external xib into a table instance.
    ///
    /// - Parameter _: nib class
    func register<T: UITableViewCell>(nibClass: T.Type) where T: ReusableCell {
        let bundle = Bundle(for: nibClass.self)
        let cellClassName: String = String(describing: nibClass.self)
        let nib = UINib(nibName: cellClassName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cellClassName)
    }
    
    /// Dequeue a cell instance strongly typed.
    ///
    /// - Parameter indexPath: index path
    /// - Returns: instance
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.dequeueIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
}
