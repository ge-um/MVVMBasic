//
//  MBTIButtonView.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/12/25.
//

import SnapKit
import UIKit

final class MBTIButtonView: UIStackView {
    let title1: String
    let title2: String
    
    init(title1: String, title2: String) {
        self.title1 = title1
        self.title2 = title2
        super.init(frame: .zero)
        
        distribution = .fillEqually
        spacing = 12
        axis = .vertical
        
        addArrangedSubview(button1)
        addArrangedSubview(button2)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button1: UIButton = {
        var config = UIButton.Configuration.borderedTinted()
        config.attributedTitle = AttributedString(title1, attributes: .init([.font: UIFont.systemFont(ofSize: 20, weight: .light)]))
        config.background.cornerRadius = 27
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let button = UIButton(configuration: config)
        
        button.configurationUpdateHandler = {
            var config = button.configuration
            
            config?.baseBackgroundColor = $0.isSelected ? .C_1: .white
            config?.baseForegroundColor = $0.isSelected ? .white: .C_2
            config?.background.strokeColor = $0.isSelected ? .clear : .C_2
            
            button.configuration = config
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.borderedTinted()
        config.attributedTitle = AttributedString(title2, attributes: .init([.font: UIFont.systemFont(ofSize: 20, weight: .light)]))
        config.background.cornerRadius = 27
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    
        button.configuration = config
        
        button.configurationUpdateHandler = {
            var config = button.configuration
            
            config?.baseBackgroundColor = $0.isSelected ? .C_1: .white
            config?.baseForegroundColor = $0.isSelected ? .white: .C_2
            config?.background.strokeColor = $0.isSelected ? .clear : .C_2
            
            button.configuration = config
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc private func buttonTapped(sender: UIButton) {
        [button1, button2].forEach {
            $0.isSelected = (sender == $0)
            $0.isUserInteractionEnabled = (sender != $0)
        }
    }
}


