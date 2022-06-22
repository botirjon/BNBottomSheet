//
//  BNBottomSheetDataSource.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

public protocol BNBottomSheetDataSource {
    func numberOfSections(in bottomSheetController: BNBottomSheetController) -> Int
    func bottomSheetController(_ controller: BNBottomSheetController, numberOfItemsInSection section: Int) -> Int
    func bottomSheetController(_ controller: BNBottomSheetController, viewForHeaderInSection section: Int) -> UIView?
    func bottomSheetController(_ controller: BNBottomSheetController, viewForFooterInSection section: Int) -> UIView?
    func bottomSheetController(_ controller: BNBottomSheetController, cellForItemAt indexPath: IndexPath) -> UITableViewCell
}

public extension BNBottomSheetDelegate {
    func numberOfSections(in bottomSheetController: BNBottomSheetController) -> Int {
        return 0
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
