//
//  NoCancelButtonSearchController.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 03/07/2021.
//

import UIKit

class NoCancelButtonSearchController: UISearchController {
    let noCancelButtonSearchBar = NoCancelButtonSearchBar()
    override var searchBar: UISearchBar { return noCancelButtonSearchBar }
}
