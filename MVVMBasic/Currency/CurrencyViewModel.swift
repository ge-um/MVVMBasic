//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class CurrencyViewModel {
    var amountText: String? = "" {
        didSet {
            validate()
        }
    }
    
    var resultText: String = "" {
        didSet {
            onConvertButtonTapped?()
        }
    }
    
    var onConvertButtonTapped: (() -> Void)?
    
    private func validate() {
        guard let amountText = amountText,
              let amount = Double(amountText) else {
            resultText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        resultText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
