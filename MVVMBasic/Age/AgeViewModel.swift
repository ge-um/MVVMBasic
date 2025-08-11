//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class AgeViewModel {
    var ageText: Observable<String?> = Observable("")
    var resultText: Observable<String?> = Observable("")
    
    private init() {
        ageText.bind { [unowned self] text in
            self.resultText.value = self.generateResultMessage(text)
        }
    }

    private func validateAge(_ text: String?) throws (AgeValidationError) -> String {
        guard let age = ageText.value else {
            throw .nil
        }
        guard !(age.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) else {
            throw .empty
        }
        guard let num = Int(age) else {
            throw .notNumber
        }
        guard (1...100) ~= num else {
            throw .outOfRange
        }
        return age
    }
    
    private func generateResultMessage(_ age: String?) -> String? {
        do {
            let resultMessage = try validateAge(age)
            return resultMessage
        } catch {
            let errorMessage = error.errorDescription
            return errorMessage
        }
    }
}
