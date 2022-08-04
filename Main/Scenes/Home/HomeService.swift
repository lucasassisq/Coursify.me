import Core

// MARK: - Class

final class HomeService: BaseService {

    func getCategories(completion: @escaping(Result<[Category], ResponseError>) -> Void) {
        let request = createRequest(path: "categories", method: .get)
        service.performRequest(route: request, completion: completion)
    }

    func getPostsFromCategory(category: Category, completion: @escaping(Result<[Post], ResponseError>) -> Void) {
        let request = createRequest(path: "posts?categories=\(category.id)", method: .get)
        service.performRequest(route: request, completion: completion)
    }

    func getMedia(post: Post, completion: @escaping(Result<Media, ResponseError>) -> Void) {
        let request = createRequest(path: "media/\(post.featuredMedia)", method: .get)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - Categories

struct Category: Codable {

    enum CodingKeys: String, CodingKey {
        case id, count
        case categoriesDescription = "description"
        case link, name, slug, taxonomy, parent
        case links = "_links"
    }

    let id, count: Int
    let categoriesDescription: String
    let link: String
    let name, slug, taxonomy: String
    let parent: Int
    let links: Links

}

// MARK: - Links

struct Links: Codable {

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection, about
        case curies
    }

    let linksSelf, collection, about: [About]
    let curies: [Cury]?

}

// MARK: - About

struct About: Codable {
    let href: String
}

// MARK: - Cury

struct Cury: Codable {
    let name, href: String
    let templated: Bool
}


// MARK: - Post
struct Post: Codable {

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case guid, modified
        case modifiedGmt = "modified_gmt"
        case slug, status, type, link, title, content, excerpt, author
        case featuredMedia = "featured_media"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case sticky, template, format, meta, categories, tags
        case pageViews = "page_views"
        case links = "_links"
    }

    let id: Int
    let date, dateGmt: String
    let guid: GUID
    let modified, modifiedGmt, slug, status: String
    let type: String
    let link: String
    let title: GUID
    let content, excerpt: Content
    let author, featuredMedia: Int
    let commentStatus, pingStatus: String
    let sticky: Bool
    let template, format: String
    let meta: Meta
    let categories, tags: [Int]
    let pageViews: Int
    let links: Links

}

// MARK: - Content

struct Content: Codable {
    let rendered: String
    let protected: Bool
}

// MARK: - GUID

struct GUID: Codable {
    let rendered: String
}

// MARK: - Author

struct Author: Codable {
    let embeddable: Bool
    let href: String
}

// MARK: - PredecessorVersion

struct PredecessorVersion: Codable {
    let id: Int
    let href: String
}

// MARK: - VersionHistory

struct VersionHistory: Codable {
    let count: Int
    let href: String
}


// MARK: - Meta

struct Meta: Codable {

    enum CodingKeys: String, CodingKey {
        case ampStatus = "amp_status"
    }
    
    let ampStatus: String
}


// MARK: - Media

struct Media: Codable {

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case guid, modified
        case modifiedGmt = "modified_gmt"
        case slug, status, type, link, title, author
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case template, meta
        case mediaDescription = "description"
        case caption
        case altText = "alt_text"
        case mediaType = "media_type"
        case mimeType = "mime_type"
        case mediaDetails = "media_details"
        case post
        case sourceURL = "source_url"
        case links = "_links"
    }

    let id: Int
    let date, dateGmt: String
    let guid: Caption
    let modified, modifiedGmt, slug, status: String
    let type: String
    let link: String
    let title: Caption
    let author: Int
    let commentStatus, pingStatus, template: String
    let meta: Meta
    let mediaDescription, caption: Caption
    let altText, mediaType, mimeType: String
    let mediaDetails: MediaDetails
    let post: Int
    let sourceURL: String
    let links: Links
}

// MARK: - Caption

struct Caption: Codable {
    let rendered: String
}


// MARK: - Attributes

struct Attributes: Codable {
    let embeddable: Bool
}

// MARK: - MediaDetails

struct MediaDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case width, height, file
        case imageMeta = "image_meta"
    }

    let width, height: Int
    let file: String
    let imageMeta: ImageMeta

}

// MARK: - ImageMeta

struct ImageMeta: Codable {

    enum CodingKeys: String, CodingKey {
        case aperture, credit, camera, caption
        case createdTimestamp = "created_timestamp"
        case copyright
        case focalLength = "focal_length"
        case iso
        case shutterSpeed = "shutter_speed"
        case title, orientation
    }

    let aperture, credit, camera, caption: String
    let createdTimestamp, copyright, focalLength, iso: String
    let shutterSpeed, title, orientation: String

}

// MARK: - Full

struct Full: Codable {

    enum CodingKeys: String, CodingKey {
        case file, width, height
        case mimeType = "mime_type"
        case sourceURL = "source_url"
    }

    let file: String
    let width, height: Int
    let mimeType: String
    let sourceURL: String

}
