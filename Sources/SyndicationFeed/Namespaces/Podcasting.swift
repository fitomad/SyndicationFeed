//
//  Podcast.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

enum Podcasting {
	static var channelTags: [String] {
		[
			Podcasting.Block.tagName,
			Podcasting.Chat.tagName,
			Podcasting.Funding.tagName,
			Podcasting.GUID.tagName,
			Podcasting.Image.tagName,
			Podcasting.Images.tagName,
			Podcasting.License.tagName,
			Podcasting.LiveItem.tagName,
			Podcasting.Location.tagName,
			Podcasting.Locked.tagName,
			Podcasting.Medium.tagName,
			Podcasting.Person.tagName,
			Podcasting.Podping.tagName,
			Podcasting.Podroll.tagName,
			Podcasting.SocialInteract.tagName,
			Podcasting.Trailer.tagName,
			Podcasting.TXT.tagName,
			Podcasting.UpdateFrequency.tagName,
			Podcasting.Value.tagName
		]
	}
	
	static var itemTags: [String] {
		[
			Podcasting.AlternateEnclosure.tagName,
			Podcasting.Chapters.tagName,
			Podcasting.ContentLink.tagName,
			Podcasting.Episode.tagName,
			Podcasting.Funding.tagName,
			Podcasting.Image.tagName,
			Podcasting.Images.tagName,
			Podcasting.License.tagName,
			Podcasting.Location.tagName,
			Podcasting.Person.tagName,
			Podcasting.Season.tagName,
			Podcasting.Episode.tagName,
			Podcasting.SocialInteract.tagName,
			Podcasting.Soundbite.tagName,
			Podcasting.Transcript.tagName,
			Podcasting.TXT.tagName,
			Podcasting.Value.tagName
		]
	}
	
	enum GUID: FeedTag {
		static let tagName = "podcast:guid"
	}
	
	enum Medium: FeedTag {
		static let tagName = "podcast:medium"
	}
	
	enum Trailer: AttributedFeedTag {
		static let tagName = "podcast:trailer"
		
		enum AttributeKeys: String {
			case url = "url"
			case pubdate = "pubdate"
			case length = "length"
			case type = "type"
			case season = "season"
		}
	}
	
	enum AlternateEnclosure: AttributedFeedTag {
		static let tagName = "podcast:alternateEnclosure"
		
		enum AttributeKeys: String {
			case type = "type"
			case length = "length"
			case bitrate = "bitrate"
			case height = "height"
			case lang = "lang"
			case title = "title"
			case codecs = "codecs"
			case isDefault = "default"
			case rel = "rel"
		}
	}
	
	enum Source: AttributedFeedTag {
		static let tagName = "podcast:source"
		
		enum AttributeKeys: String {
			case uri = "uri"
			case contentType = "contentType"
		}
	}

	enum LiveItem: AttributedFeedTag {
		static let tagName = "podcast:liveItem"
		
		enum AttributeKeys: String {
			case status = "status"
			case start = "start"
			case end = "end"
		}
		
		static let title = "title"
		static let description = "description"
		static let link = "link"
		static let guid = "guid"
		static let author = "author"
		static let images = "podcast:images"
		static let person = "podcast:person"
		static let alternateEnclosure = "podcast:alternateEnclosure"
		static let enclosure = "enclosure"
		static let contentLink = "podcast:contentLink"
	}
	
	enum ContentLink: AttributedFeedTag {
		static let tagName = "podcast:contentLink"
		
		enum AttributeKeys: String {
			case href = "href"
		}
	}
	
	enum License: AttributedFeedTag {
		static let tagName = "podcast:license"
		
		enum AttributeKeys: String {
			case url = "url"
		}
	}
	
	enum Locked: AttributedFeedTag {
		static let tagName = "podcast:locked"
		
		enum AttributeKeys: String {
			case owner = "owner"
		}
	}
	
	enum Block: AttributedFeedTag {
		static let tagName = "podcast:block"
		
		enum AttributeKeys: String {
			case id = "id"
		}
	}
	
	enum Funding: AttributedFeedTag {
		static let tagName = "podcast:funding"
		
		enum AttributeKeys: String {
			case url = "url"
		}
	}
	
	enum Location: AttributedFeedTag {
		static let tagName = "podcast:location"
		
		enum AttributeKeys: String {
			case rel = "rel"
			case  geo = "geo"
			case  osm = "osm"
			case  country = "country"
		}
	}
	
	enum Image: AttributedFeedTag {
		static let tagName = "podcast:image"
		
		enum AttributeKeys: String {
			case href = "href"
			case alt = "alt"
			case aspectRatio = "aspect-ratio"
			case width = "width"
			case height = "height"
			case type = "type"
			case purpose = "purpose"
		}
	}
	
	enum Images: AttributedFeedTag {
		static let tagName = "podcast:images"
		
		enum AttributeKeys: String {
			case srcset = "srcset"
		}
	}
	
	enum Season: AttributedFeedTag {
		static let tagName = "podcast:season"
		
		enum AttributeKeys: String {
			case name = "name"
		}
	}
	
	enum Episode: AttributedFeedTag {
		static let tagName = "podcast:episode"
		
		enum AttributeKeys: String {
			case display = "display"
		}
	}
	
	enum Chapters: AttributedFeedTag {
		static let tagName = "podcast:chapters"
		
		enum AttributeKeys: String {
			case url = "url"
			case type = "type"
		}
	}
	
	enum Soundbite: AttributedFeedTag {
		static let tagName = "podcast:soundbite"
		
		enum AttributeKeys: String {
			case startTime = "startTime"
			case duration = "duration"
		}
	}
	
	enum Transcript: AttributedFeedTag {
		static let tagName = "podcast:transcript"
		
		enum AttributeKeys: String {
			case url = "url"
			case type = "type"
			case language = "language"
			case rel = "rel"
		}
	}
	
	enum Person: AttributedFeedTag {
		static let tagName = "podcast:person"
		
		enum AttributeKeys: String {
			case role = "role"
			case group = "group"
			case img = "img"
			case href = "href"
		}
	}
	
	enum Value: AttributedFeedTag {
		static let tagName = "podcast:value"
		
		enum AttributeKeys: String {
			case method = "method"
			case type = "type"
			case suggested = "suggested"
		}
	}
	
	enum ValueRecipient: AttributedFeedTag {
		static let tagName = "podcast:valueRecipient"
		
		enum AttributeKeys: String {
			case name = "name"
			case customKey = "customKey"
			case customValue = "customValue"
			case type = "type"
			case address = "address"
			case split = "split"
			case fee = "fee"
		}
	}
	
	enum SocialInteract: AttributedFeedTag {
		static let tagName = "podcast:socialInteract"
		
		enum AttributeKeys: String {
			case `protocol` = "protocol"
			case uri = "uri"
			case accountId = "accountId"
			case accountUrl = "accountUrl"
			case priority = "priority"
			
		}
	}
	
	enum TXT: AttributedFeedTag {
		static let tagName = "podcast:txt"
		
		enum AttributeKeys: String {
			case purpose = "purpose"
		}
	}
	
	enum UpdateFrequency: AttributedFeedTag {
		static let tagName = "podcast:updateFrequency"
		
		enum AttributeKeys: String {
			case complete = "complete"
			case dtstart = "dtstart"
			case rrule = "rrule"
		}
	}
	
	enum Integrity: AttributedFeedTag {
		static let tagName = "podcast:integrity"
		
		enum AttributeKeys: String {
			case type = "type"
			case value = "value"
		}
	}
	
	enum Chat: AttributedFeedTag {
		static let tagName = "podcast:chat"
		
		enum AttributeKeys: String {
			case server = "server"
			case networkProtocol = "protocol"
			case accountID = "accountId"
			case space = "space"
		}
	}
	
	enum Podping: AttributedFeedTag {
		static let tagName = "podcast:podping"
		
		enum AttributeKeys: String {
			case usesPodping = "usesPodping"
		}
	}
	
	enum Podroll: FeedTag {
		static let tagName = "podcast:podroll"
	}
	
	enum RemoteItem: AttributedFeedTag {
		static let tagName = "podcast:remoteItem"
		
		enum AttributeKeys: String {
			case feedGUID = "feedGuid"
			case feedURL = "feedUrl"
			case itemGUID = "itemGuid"
			case medium = "medium"
			case title = "title"
		}
	}
}
