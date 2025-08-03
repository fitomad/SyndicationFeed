//
//  Tags.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

enum RSS {
	static var channelTags: [String] {
		[
			RSS.Image.tagName,
			RSS.Item.tagName,
			RSS.Title.tagName,
			RSS.Description.tagName,
			RSS.Link.tagName,
			RSS.Language.tagName,
			RSS.Copyright.tagName,
			RSS.ManagingEditor.tagName,
			RSS.WebMaster.tagName,
			RSS.PubDate.tagName,
			RSS.LastBuildDate.tagName,
			RSS.Category.tagName,
			RSS.Generator.tagName,
			RSS.Docs.tagName,
			RSS.Cloud.tagName,
			RSS.TTL.tagName,
			RSS.Rating.tagName,
			RSS.SkipHours.Hour.tagName,
			RSS.SkipDays.Day.tagName
		]
	}
	
	static var itemTags: [String] {
		[
			RSS.Title.tagName,
			RSS.Description.tagName,
			RSS.Link.tagName,
			RSS.Author.tagName,
			RSS.Category.tagName,
			RSS.Comments.tagName,
			RSS.Enclosure.tagName,
			RSS.GUID.tagName,
			RSS.PubDate.tagName,
			RSS.Source.tagName
		]
	}
	
	enum Channel: FeedTag {
		static let tagName = "channel"
	}
	
	enum Title: FeedTag {
		static let tagName = "title"
	}
	
	enum Description: FeedTag {
		static let tagName = "description"
	}
	
	enum Link: FeedTag {
		static let tagName = "link"
	}
	
	enum Docs: FeedTag {
		static let tagName = "docs"
	}
	
	enum Language: FeedTag {
		static let tagName = "language"
	}
	
	enum Copyright: FeedTag {
		static let tagName = "copyright"
	}
	
	enum Generator: FeedTag {
		static let tagName = "generator"
	}
	
	enum PubDate: FeedTag {
		static let tagName = "pubDate"
	}
	
	enum LastBuildDate: FeedTag {
		static let tagName = "lastBuildDate"
	}
	
	enum ManagingEditor: FeedTag {
		static let tagName = "managingEditor"
	}
	
	enum WebMaster: FeedTag {
		static let tagName = "webMaster"
	}
	
	enum Item: FeedTag {
		static let tagName = "item"
	}
	
	enum Author: FeedTag {
		static let tagName = "author"
	}
	
	enum Category: AttributedFeedTag {
		static let tagName = "category"
		
		enum AttributeKeys: String {
			case domain = "domain"
		}
	}
	
	enum Comments: FeedTag {
		static let tagName = "comments"
	}
	
	enum Image: AttributedFeedTag {
		static let tagName = "image"
		
		enum AttributeKeys: String {
			case image = "image"
			case url = "url"
			case title = "title"
			case link = "link"
			case description = "description"
			case width = "width"
			case height = "height"
		}
	}
	
	enum Source: AttributedFeedTag {
		static let tagName = "source"
		
		enum AttributeKeys: String {
			case url = "url"
		}
	}
	
	enum Enclosure: AttributedFeedTag {
		static let tagName = "enclosure"
		
		enum AttributeKeys: String {
			case url = "url"
			case length = "length"
			case type = "type"
		}
	}
	
	enum GUID: AttributedFeedTag {
		static let tagName = "guid"
		
		enum AttributeKeys: String {
			case isPermalink = "isPermaLink"
		}
	}
	
	enum Cloud: AttributedFeedTag {
		static let tagName = "cloud"
		
		enum AttributeKeys: String {
			case domain = "domain"
			case port = "port"
			case path = "path"
			case registerProcedure = "registerProcedure"
			case networkProtocol = "protocol"
		}
	}
	
	enum TTL: FeedTag {
		static let tagName = "ttl"
	}
	
	enum Rating: FeedTag {
		static let tagName = "rating"
	}
	
	enum SkipHours: FeedTag {
		static let tagName = "skipHours"
		
		enum Hour: FeedTag {
			static let tagName = "hour"
		}
	}
	
	enum SkipDays: FeedTag {
		static let tagName = "skipDays"
		
		enum Day: FeedTag {
			static let tagName = "day"
		}
	}
}
