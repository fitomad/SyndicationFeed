//
//  DateFormatter+PublicationDate.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

extension DateFormatter {
	// Fri, 09 Oct 2020 04:30:38 GMT
	public static var publicationDateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
		formatter.locale = Locale(identifier: "en_US_POSIX")
		
		return formatter
	}
}
