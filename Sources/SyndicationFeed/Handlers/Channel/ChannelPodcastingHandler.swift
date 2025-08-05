//
//  ChannelPodcastingHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

final class ChannelPodcastingHandler: TagHandler {
	var podcasting = Channel.Podcasting()
	weak var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) throws(SyndicationFeedError) {
		guard Podcasting.channelTags.contains(tagName) else {
			try nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
			return
		}
		
		switch tagName {
			case Podcasting.Block.tagName:
				let mapper = BlockMapper()
				podcasting.block = mapper.mapToBlock(using: attributesDict, status: text)
			case Podcasting.Chat.tagName:
				let mapper = ChatMapper()
				podcasting.chat = try? mapper.mapToChat(using: attributesDict)
			case Podcasting.Funding.tagName:
				let mapper = FundingMapper()
				podcasting.funding = try? mapper.mapToFunding(using: attributesDict, message: text)
			case Podcasting.GUID.tagName:
				podcasting.guid = UUID(uuidString: text)
			case Podcasting.Image.tagName:
				let mapper = PodcastImageMapper()
				let image = try mapper.mapToPodcastImage(from: attributesDict)
				addImage(image)
			case Podcasting.Images.tagName:
				let mapper = ImageSetMapper()
				podcasting.imageSet = try mapper.mapToImages(from: attributesDict)
			case Podcasting.License.tagName:
				let mapper = LicenseMapper()
				podcasting.license = mapper.mapToLicense(using: attributesDict, titled: text)
			case Podcasting.Location.tagName:
				let mapper = LocationMapper()
				let location = mapper.mapToLocation(from: attributesDict, place: text)
				addLocation(location)
			case Podcasting.Locked.tagName:
				let mapper = LockedMapper()
				podcasting.locked = mapper.mapToLocked(using: attributesDict, locked: text)
			case Podcasting.Medium.tagName:
				podcasting.medium = Medium(rawValue: text)
			case Podcasting.Person.tagName:
				let mapper = PersonMapper()
				let person = mapper.mapToPerson(from: attributesDict, name: text)
				addPerson(person)
			case Podcasting.Podping.tagName:
				let mapper = PodpingMapper()
				podcasting.usesPodping = mapper.mapToBool(using: attributesDict)
			case Podcasting.SocialInteract.tagName:
				let mapper = SocialInteractMapper()
				let profile = try mapper.mapToSocialInteract(from: attributesDict)
				addSocialProfile(profile)
			case Podcasting.Trailer.tagName:
				let mapper = TrailerMapper()
				let trailer = try mapper.mapToTrailer(from: attributesDict, title: text)
				addTrailer(trailer)
			case Podcasting.TXT.tagName:
				let mapper = TXTMapper()
				let txt = mapper.mapToTXT(from: attributesDict, text: text)
				addTXT(txt)
			case Podcasting.UpdateFrequency.tagName:
				let mapper = UpdateFrequencyMapper()
				podcasting.updateFrequency = mapper.mapToUpdateFrequency(using: attributesDict, text: text)
			default:
				try nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
	
	private func addImage(_ image: PodcastImage?) {
		if podcasting.images == nil {
			podcasting.images = [PodcastImage]()
		}
		
		if let image {
			podcasting.images?.append(image)
		}
	}
	
	private func addLocation(_ location: Location?) {
		if podcasting.locations == nil {
			podcasting.locations = [Location]()
		}
		
		if let location {
			podcasting.locations?.append(location)
		}
	}
	
	private func addPerson(_ person: Person) {
		if podcasting.personas == nil {
			podcasting.personas = [Person]()
		}
		
		podcasting.personas?.append(person)
	}
	
	private func addSocialProfile(_ profile: SocialInteract?) {
		if podcasting.socialProfiles == nil {
			podcasting.socialProfiles = [SocialInteract]()
		}
		
		if let profile {
			podcasting.socialProfiles?.append(profile)
		}
	}
	
	private func addTrailer(_ trailer: Trailer?) {
		if podcasting.trailers == nil {
			podcasting.trailers = [Trailer]()
		}
		
		if let trailer {
			podcasting.trailers?.append(trailer)
		}
	}
	
	private func addTXT(_ txt: TXT) {
		if podcasting.txts == nil {
			podcasting.txts = [TXT]()
		}
		
		podcasting.txts?.append(txt)
	}
}

extension ChannelPodcastingHandler: ChannelTagHandler {
	func applyChanges(to channel: inout Channel) {
		channel.podcasting = podcasting
	}
}
