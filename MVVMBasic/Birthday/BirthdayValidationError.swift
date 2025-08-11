//
//  BirthdayValidationError.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/7/25.
//

import Foundation

enum BirthdayValidationError {
    case `nil`
    case noYear
    case noMonth
    case noDay
    case notNumber
    case outOfRangeYear
    case outOfRangeMonth
    case outOfRangeDay
}

extension BirthdayValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nil:
            return "nil입니다."
        case .noYear:
            return "년도를 입력해주세요"
        case .noMonth:
            return "달을 입력해주세요"
        case .noDay:
            return "날짜를 입력해주세요"
        case .notNumber:
            return "숫자를 입력해주세요"
        case .outOfRangeYear:
            return "0~2025 범위의 연도를 입력해주세요."
        case .outOfRangeMonth:
            return "1~12 범위의 월을 입력해주세요."
        case .outOfRangeDay:
            return "1~30 범위의 일을 입력해주세요."
        }
    }
}
