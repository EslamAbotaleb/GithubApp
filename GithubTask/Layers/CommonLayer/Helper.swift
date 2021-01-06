//
//  Helper.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit
class HelperUtils {
    static var shared: HelperUtils = HelperUtils()

    
    func getFormatedDate(formatDate: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: formatDate)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
