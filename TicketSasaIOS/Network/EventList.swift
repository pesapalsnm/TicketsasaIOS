//
//  EventList.swift
//  TicketSasaIOS
//
//  Created by Samuel Nyamai on 31/03/2024.
//

import Foundation

// MARK: - Welcome
struct EventList: Codable {
    let success: Bool
    let events: [Event]
    let user: User
}

// MARK: - Event
struct Event: Identifiable, Codable {
    let id: Int
    let name: String
    let location: String
    let startDate: Int
//    let currency: Currency

    enum CodingKeys: String, CodingKey {
        case id, name, location
        case startDate = "start_date"
//        case currency
    }
}

//enum Currency: String, Codable {
//    case empty = ""
//    case kes = "KES"
//    case tzs = "TZS"
//    case ugx = "UGX"
//    case usd = "USD"
//}

//// MARK: - User
//struct User: Codable {
//    let id, name, username, email: String
//    let password, passwordClear, block, sendEmail: String
//    let registerDate, lastvisitDate, activation, params: String
//    let groups: [String: String]
//    let guest: Int
//    let lastResetTime, resetCount, facebook, twitter: String
//    let google, phone, userid, processed: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, username, email, password
//        case passwordClear = "password_clear"
//        case block, sendEmail, registerDate, lastvisitDate, activation, params, groups, guest, lastResetTime, resetCount, facebook, twitter, google, phone
//        case userid = "USERID"
//        case processed
//    }
//}
