//
//  MBTIButton.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

import SnapKit
import UIKit

final class MBTIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
