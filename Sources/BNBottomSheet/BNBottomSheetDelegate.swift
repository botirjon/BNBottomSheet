//
//  BNBottomSheetDelegate.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

public protocol BNBottomSheetDelegate {
    func bottomSheetController(_ controller: BNBottomSheetController, heightForItemAt indexPath: IndexPath) -> CGFloat
    func bottomSheetController(_ controller: BNBottomSheetController, heightForHeaderInSection section: Int) -> CGFloat
    func bottomSheetController(_ controller: BNBottomSheetController, heightForFooterInSection section: Int) -> CGFloat
    
    func bottomSheetController(_ controller: BNBottomSheetController, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets
    
    func bottomSheetController(_ controller: BNBottomSheetController, didSelectItemAt indexPath: IndexPath)
    func bottomSheetController(_ controller: BNBottomSheetController, separatorInsetForItemAt indexPath: IndexPath) -> UIEdgeInsets
    func bottomSheetControllerDidCancel(_ controller: BNBottomSheetController)
}

public extension BNBottomSheetDelegate {
    func bottomSheetControllerDidCancel(_ controller: BNBottomSheetController) {}
    
    func bottomSheetController(_ controller: BNBottomSheetController, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    
    func bottomSheetController(_ controller: BNBottomSheetController, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func bottomSheetController(_ controller: BNBottomSheetController, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        return .zero
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, separatorInsetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        return .zero
    }
}
