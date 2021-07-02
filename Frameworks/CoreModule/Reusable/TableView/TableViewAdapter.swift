//
//  TableViewAdapter.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 31/03/2021.
//

import UIKit

open class TableViewAdapter: NSObject, UITableViewDelegate {
    
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.configureTableView()
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return nil }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }
    
    open func configureTableView() {
        fatalError("Not Implemented")
    }
}
