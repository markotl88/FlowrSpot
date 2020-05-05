//
//  String+Extension.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

extension String {
    
    func date(withDateFormat dateFormat: DateFormat = DateFormat.server, andLocale locale: SupportedLocale = .en) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: locale.rawValue)
        return formatter.date(from: self)
    }
}
