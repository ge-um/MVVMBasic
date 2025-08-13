//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

final class CurrencyViewModel {
    var amountText: Observable<String?> = Observable("")
    var resultText: Observable<String?> = Observable("")

    init() {
        amountText.lazyBind { [unowned self] text in
            self.resultText.value = validate(text)
        }
    }
        
    private func validate(_ text: String?) -> String? {
        guard let amountText = amountText.value,
              let amount = Double(amountText) else {
            return "올바른 금액을 입력해주세요"
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        return String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
