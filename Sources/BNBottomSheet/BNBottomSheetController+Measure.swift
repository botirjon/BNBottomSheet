//
//  BottomSheetController+Measure.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

extension BNBottomSheetController {
    
    func tableViewHeight() -> CGFloat {
        var proposedHeight = contentHeight() + viewMargins.bottom + bottomPatchOffset - 10
        if proposedHeight > tableViewMaximumHeight() {
            proposedHeight = tableViewMaximumHeight()
        }
        return proposedHeight
    }
    
    /// computes maximum height that table view can have
    func tableViewMaximumHeight() -> CGFloat {
        return view.bounds.maxY+bottomPatchOffset-viewMargins.top-topMargin
    }
    
    /// computes content height for bottom sheet controller
    func contentHeight() -> CGFloat {
        var height: CGFloat = 0
        
        let sections = dataSource?.numberOfSections(in: self) ?? 0
        
        for section in 0 ..< sections {
            height += (delegate?.bottomSheetController(self, heightForHeaderInSection: section) ?? 0)
            height += (delegate?.bottomSheetController(self, heightForFooterInSection: section) ?? 0)
            let rows = (dataSource?.bottomSheetController(self, numberOfItemsInSection: section) ?? 0)
            
            for row in 0 ... rows {
                height += delegate?.bottomSheetController(self, heightForItemAt: IndexPath.init(row: row, section: section)) ?? 0
            }
        }
        
        return height
    }
    
    func topHeaderHeight() -> CGFloat {
        guard (dataSource?.numberOfSections(in: self) ?? 0) > 0 else {
            return 0
        }
        let height = delegate?.bottomSheetController(self, heightForHeaderInSection: 0) ?? 0
        return height + 16
    }
}

extension UIViewController {
    
    var viewMargins: UIEdgeInsets {
        view.safeAreaInsets
    }
}
