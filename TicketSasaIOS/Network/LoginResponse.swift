//
//  LoginResponse.swift
//  TicketSasaIOS
//
//  Created by Samuel Nyamai on 31/03/2024.
//

import Foundation

struct LoginRequest :Codable {
    let username, password: String

    enum CodingKeys: String, CodingKey {
        case username, password
    }
}

struct ErrorResponse: Codable {
    let error: Bool
//    let errorMessage, username, password: String
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case error
        case errorMessage = "error_message"
//        case username, password
    }
}

// MARK: - Welcome
struct LoginResponse: Codable {
    var success: Bool
    let token: String
    let user: User
    
    
//    enum CodingKeys: String, CodingKey {
//        case success,token,user
//    }
    
}

// MARK: - User
struct User:Identifiable, Codable {
    let id, name, username, email: String
    let password, passwordClear, block, sendEmail: String
    let registerDate, lastvisitDate, activation, params: String
    let groups: [String: String]
    let guest: Int
    let lastResetTime, resetCount: String
    var aid: Int?
    let facebook, twitter, google, phone: String
    let userid, processed: String

    enum CodingKeys: String, CodingKey {
        case id, name, username, email, password
        case passwordClear = "password_clear"
        case block, sendEmail, registerDate, lastvisitDate, activation, params, groups, guest, lastResetTime, resetCount, aid, facebook, twitter, google, phone
        case userid = "USERID"
        case processed
    }
}
