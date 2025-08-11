//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class BMIViewModel {
    var weightText: Observable<String?> = Observable("")
    var heightText: Observable<String?> = Observable("")
    var resultText: Observable<String?> = Observable("")

    private init() {
        weightText.bind { [unowned self] text in
            self.resultText.value = self.generateResultMessage()
        }
        heightText.bind { [unowned self] text in
            self.resultText.value = self.generateResultMessage()
        }
    }

    private func validateBMI() throws (BMIValidationError){
        guard let heightText = heightText.value, let weightText = weightText.value else {
            throw .nil
        }
        guard !heightText.isEmpty else {
            throw .noHeight
        }
        guard let height = Int(heightText) else {
            throw .notNumber
        }
        
        guard (0...300) ~= height else {
            throw .heightOutOfRange
        }
        guard !weightText.isEmpty else {
            throw .noWeight
        }
        guard let weight = Int(weightText) else {
            throw .notNumber
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
            
            let weight = Double(weightText.value!)!
            let height = Double(heightText.value!)! / 100
            
            let bmi = calculateBMI(height: height, weight: weight)
            return "bmi는 \(bmi)입니다."
            
        } catch {
            return error.localizedDescription
        }
    }
}
