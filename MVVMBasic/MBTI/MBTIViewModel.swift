//
//  MBTIViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class MBTIViewModel {
    var nicknameText: String? {
        didSet {
            stateText = generateStateMessage()
        }
    }
    
    var stateText: String? {
        didSet {
            onCompleteButtonTapped?()
        }
    }
    
    var stateTextColor: Bool = false
    
    var onCompleteButtonTapped: (() -> Void)?
    
    private func validate() throws (NicknameValidationError) {
        guard let nickname = nicknameText else { throw .nil }
        
        guard (2..<10) ~= nickname.count else {
            throw .outOfRange
        }
        
        guard !nickname.contains(/[@#$%]/) else {
            throw .containsSpecialCharacter
        }
        
        guard nickname.allSatisfy ({ !$0.isNumber }) else {
            throw .containsNumber
        }
    }
    
    private func generateStateMessage() -> String? {
        do {
            try validate()
            stateTextColor = true
            return "사용할 수 있는 닉네임이에요."
        } catch {
            stateTextColor = false
            return error.errorDescription
        }
    }
}

