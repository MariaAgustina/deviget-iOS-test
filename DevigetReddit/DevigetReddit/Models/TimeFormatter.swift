//
//  TimeFormatter.swift
//  DevigetReddit
//
//  Created by agustina markosich on 1/14/20.
//  Copyright © 2020 agustina markosich. All rights reserved.
//

import UIKit

class TimeFormatter: NSObject {
    func getStringFormat(from date_utc: Int64) -> String?{

        let hours = abs((Date(timeIntervalSince1970: TimeInterval(date_utc)).timeIntervalSinceNow)/3600)
        return String(Int(hours))
    }
}
