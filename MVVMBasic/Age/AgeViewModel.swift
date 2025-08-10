//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class AgeViewModel {
    var ageText: String? = "" {
        didSet {
            resultText = generateResultMessage()
        }
    }
    
    var resultText: String? = "" {
        didSet {
            onResultButtonTapped?()
        }
    }
    
    var onResultButtonTapped: (() -> Void)?
    
    private func validateAge() throws (AgeValidationError) -> String {
        guard let text = ageText else {
            throw .nil
        }
        guard !(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) else {
            throw .empty
        }
        guard let num = Int(text) else {
            throw .notNumber
        }
        guard (1...100) ~= num else {
            throw .outOfRange
        }
        return text
    }
    
    private func generateResultMessage() -> String? {
        do {
            return try validateAge()
        } catch {
            return error.errorDescription
        }
    }
}
