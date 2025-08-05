//
//  Medium.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

public enum Medium: String, Sendable {
	case podcast
	case podcastList = "podcastL"
	case music
	case musicList = "musicL"
	case video
	case videoList = "videoL"
	case film
	case filmList = "filmL"
	case audiobook
	case audiobookList = "audiobookL"
	case newsletter
	case newsletterList = "newsletterL"
	case blog
	case blogList = "blogL"
	case publisher
	case publisherList = "publisherL"
	case course
	case courseList = "courseL"
}
