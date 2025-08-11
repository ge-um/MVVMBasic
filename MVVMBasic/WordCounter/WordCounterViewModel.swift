//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/9/25.
//

final class WordCounterViewModel {
    var newText = Observable("")
    var resultText = Observable("")
    
    init() {
        newText.bind { [unowned self] text in
            resultText.value = updateCount(text)
        }
    }
    
//    var onCountChanged: (() -> Void)?
    
//    var newText: String = "" {
//        didSet {
//            updateCount()
//        }
//    }
    
//    var resultText: String = "" {
//        didSet {
//            onCountChanged?()
//        }
//    }
 
    private func updateCount(_ text: String) -> String {
        return "현재까지 \(text.count)글자 작성중"
    }
}
