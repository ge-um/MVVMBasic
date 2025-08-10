//
//  MBTIViewController.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

import SnapKit
import UIKit

final class MBTIViewController: UIViewController {
    private var navigationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .C_2.withAlphaComponent(0.3)
        return view
    }()
    
    private var profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .C_1
        return imageView
    }()
    
    private var nicknameTextField: UITextField = {
       let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [.foregroundColor: UIColor.C_2, .font: UIFont.systemFont(ofSize: 15)])
        textField.textColor = .black
        return textField
    }()
    
    private var textFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .C_2.withAlphaComponent(0.3)
        return view
    }()
    
    private var stateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .C_3
        return label
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "완료"
        config.baseBackgroundColor = .C_2
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    private let viewModel = MBTIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpUI()
        setUpAction()
        bindViewModel()
    }
    
    private func setUpUI() {
        view.addSubview(navigationLine)
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldLine)
        view.addSubview(completeButton)
        view.addSubview(stateLabel)
        
        navigationLine.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationLine.snp.bottom).offset(28)
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
        }
        
        textFieldLine.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldLine.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
        }
        
        completeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
 
    private func setUpNavigationBar() {
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        if navigationController?.viewControllers.first !== self {
            var config = UIButton.Configuration.plain()
            
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -4, bottom: 0, trailing: 0)
            config.baseForegroundColor = .black
            config.image = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))
            
            let backButton = UIButton(configuration: config)
            
            backButton.addAction(.init { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }, for: .touchUpInside)
            
            let barButton = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = barButton
        }
    }
    
    private func setUpAction() {
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.onCompleteButtonTapped = { [unowned self] in
            self.stateLabel.text = self.viewModel.stateText
            self.stateLabel.textColor = self.viewModel.stateTextColor ? .C_1 : .C_3
        }
    }
    
    @objc private func completeButtonTapped() {
        viewModel.nicknameText = nicknameTextField.text
    }
}
