//
//  BottomSheetController+TableView.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

extension BNBottomSheetController {
    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        if isViewLoaded {
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        }
        else {
            if let _class = cellClass {
                reusableCells[identifier] = _class
            }
        }
    }
    
    public func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

extension BNBottomSheetController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.bottomSheetController(self, numberOfItemsInSection: section) ?? 0
    }
    
    /// - TAG: - Item
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dataSource?.bottomSheetController(self, cellForItemAt: indexPath) else {
            return UITableViewCell.init()
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.bottomSheetController(self, heightForItemAt: indexPath) ?? 0
    }
    
    /// - TAG: - Header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dataSource?.bottomSheetController(self, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.bottomSheetController(self, heightForHeaderInSection: section) ?? 0
    }
    
    
    /// - TAG: - Footer
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dataSource?.bottomSheetController(self, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.bottomSheetController(self, heightForFooterInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        
        delegate?.bottomSheetController(self, didSelectItemAt: indexPath)
        if autoClosesWhenItemSelected {
            close()
        }
    }
}

