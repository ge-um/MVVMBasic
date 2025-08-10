//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/9/25.
//

final class WordCounterViewModel {
    var onCountChanged: (() -> Void)?
    
    var newText: String = "" {
        didSet {
            updateCount()
        }
    }
    
    var resultText: String = "" {
        didSet {
            onCountChanged?()
        }
    }
 
    private func updateCount() {
        resultText = "현재까지 \(newText.count)글자 작성중"
    }
}
