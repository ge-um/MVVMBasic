//
//  Observable.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/11/25.
//

final class Observable<T> {
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("value changed", oldValue, value)
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func lazyBind(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    func bind(action: @escaping (T) -> Void) {
        self.action = action
    }
}
