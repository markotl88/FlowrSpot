//
//  Date+Extension.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case server = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case short = "yyyy MM dd"
    case shortWithMonth = "yyyy MMMM dd"
    case long = "yyyy MM dd, HH:mm"
    case longWithMonth = "yyyy MMMM dd, HH:mm"
    case serbianLong = "dd. MMMM yyyy, HH:mm"
    case serbianShort = "dd.MM.yyyy."
}

public enum SupportedLocale: String {
    case en = "en"
    case srLatin = "sr_Latn"
    case srCyrillic = "sr"
}

extension Date {
    func string(withDateFormate dateFormat: DateFormat = DateFormat.server, andLocale locale: SupportedLocale = .en) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: locale.rawValue)
        return formatter.string(from: self)
    }
}
