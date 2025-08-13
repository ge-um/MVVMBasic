//
//  MBTIViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class MBTIViewModel {
    struct Input {
        var nickname: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        var stateText: Observable<String?> = Observable(nil)
        var stateTextColor: Observable<Bool> = Observable(false)
    }
    
    var input: Input
    var output: Output
    
    init() {
        input = Input()
        output = Output()

        input.nickname.lazyBind { [unowned self] _ in
            self.evaluateNicknameValidation()
        }
    }
    
    private func validate() throws (NicknameValidationError) {
        guard let nickname = input.nickname.value else { throw .nil }
        
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
    
    private func evaluateNicknameValidation() {
        do {
            try validate()
            output.stateText.value = "사용할 수 있는 닉네임이에요."
            output.stateTextColor.value = true
        } catch {
            output.stateText.value = error.errorDescription
            output.stateTextColor.value = false
        }
    }
}

