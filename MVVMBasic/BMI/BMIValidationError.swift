//
//  BMIValidationError.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/7/25.
//

import Foundation

enum BMIValidationError: Error {
    case `nil`
    case noWeight
    case noHeight
    case notNumber
    case heightOutOfRange
    case weightOutOfRange
}

extension BMIValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nil:
            return "nil입니다."
        case .noWeight:
            return "몸무게를 입력해주세요."
        case .noHeight:
            return "키를 입력해주세요."
        case .notNumber:
            return "숫자를 입력해주세요"
        case .heightOutOfRange:
            return "0~300 범위의 키를 입력해주세요."
        case .weightOutOfRange:
            return "0~600 범위의 몸무게를 입력해주세요."
        }
    }
}
