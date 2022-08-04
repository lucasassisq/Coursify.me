import Foundation

// MARK: - Class

public class Url {
    
    // MARK: - Public variables
    
    public static let shared = Url()
    public var baseUrl = "https://blog.coursify.me/wp-json/wp/v2/" // Url base api
}

public extension Url {
    
    // MARK: - Internal methods
    
    func configure(url: String) {
        self.baseUrl = url
    }
    
    func getDomain() -> String {
        let url = URL(string: self.baseUrl)?.host ?? ""
        return "https://"+url
    }
}
