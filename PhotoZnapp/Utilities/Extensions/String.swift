//
//  String.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 11.09.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import Foundation

extension String {
    func makeDateStringReadable() -> String
    {
        //I couldnt cast string from api to date. I applied a temporary fix.
        //2018-09-09T09:33:45-04:00
        var fixedDateString = self
        fixedDateString.removeLast(6)
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        let date = dateFormatter.date(from: fixedDateString)
        //2018-09-09T11:26:55-04:00
        guard let convertedDate = date else {
            return self
        }
        dateFormatter.dateFormat = "dd MMMM hh:mm" //25 november saturday, 17.00
        return dateFormatter.string(from: convertedDate)
    }
}
