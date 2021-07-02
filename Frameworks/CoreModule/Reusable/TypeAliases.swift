//
//  TypeAliases.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 01/03/2021.
//

import UIKit

public typealias AppTableViewCell = UITableViewCell & ReusableCell
public typealias AppCollectionViewCell = UICollectionViewCell & ReusableCell
public typealias AppCollectionReusableView = UICollectionReusableView & ReusableCell
//
public typealias DiffableSection = Hashable & CaseIterable
public typealias DiffableCollectionViewSnapshot<S: DiffableSection, T: DiffableItem> = NSDiffableDataSourceSnapshot<S, T>
