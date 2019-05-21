//
//  TabeViewScroll.swift
//  Flash Chatt
//
//  Created by Mohamed Ibrahem on 2/11/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    func ScrollToBottom() {
        if numberOfItems(inSection: 0) > 0 {
            self.scrollToItem(at: NSIndexPath(row: self.numberOfItems(inSection: 0)-1, section: 0) as IndexPath, at: .bottom, animated: true)
        }
    }
}
