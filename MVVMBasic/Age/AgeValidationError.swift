//
//  AgeValidationError.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/7/25.
//

import Foundation

enum AgeValidationError : Error {
    case `nil`
    case empty
    case outOfRange
    case notNumber
}

extension AgeValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nil:
            return "nil입니다."
        case .empty:
            return "빈 문자열이 아닌 문자를 입력해주세요."
        case .outOfRange:
            return "1에서 100 사이의 숫자를 입력해주세요."
        case .notNumber:
            return "숫자를 입력해주세요."
        }
    }
}
