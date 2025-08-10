//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class BMIViewModel {
    var weightText: String? = "" {
        didSet {
            updateBMI()
        }
    }
    
    var heightText: String? = "" {
        didSet {
            updateBMI()
        }
    }
    
    private func updateBMI() {
        resultText = generateResultMessage()
    }
    
    var resultText: String? {
        didSet {
            onResultButtonTapped?()
        }
    }
    
    var onResultButtonTapped: (() -> Void)?

    private func validateBMI() throws (BMIValidationError){
        guard let heightText = heightText, let weightText = weightText else {
            throw .nil
        }
        guard let height = Int(heightText), let weight = Int(weightText) else {
            throw .notNumber
        }
        guard (0...300) ~= height else {
            throw .heightOutOfRange
        }
        guard (0...600) ~= weight else {
            throw .weightOutOfRange
        }
        return
    }
    
    private func calculateBMI(height: Double, weight: Double) -> String {
        let bmi = weight / (height * height)
        
        return String(format: "%.2f", bmi)
    }
    
    private func generateResultMessage() -> String? {
        do {
            try validateBMI()
            
            let weight = Double(weightText!)!
            let height = Double(heightText!)! / 100
            
            let bmi = calculateBMI(height: height, weight: weight)
            return "bmi는 \(bmi)입니다."
            
        } catch {
            return error.localizedDescription
        }
    }
}
