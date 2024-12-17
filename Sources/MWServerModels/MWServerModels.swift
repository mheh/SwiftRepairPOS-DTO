// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// MARK: - MWServer API Configuration

/// Protocol for Frontend to interact with the MWServer
/// When a user is logged into the frontend UI, the token is stored here along with server credentials
public protocol MWServerConfigurationProtocol {
    /// The web address of the server
    /// ex: 10.1.0.15
    var serverAddress: String? { get set }
    /// The server's version
    var serverVersion: MWServerVersion? { get }
    /// TLS Configuration Data for communication to the server
    var tlsData: Data? { get }
    /// Stored auth token
    var authToken: Auth_DTO.Token? { get set }
}

extension MWServerConfigurationProtocol {
    /// Create a URL Request with our MWRequestProtocol
    func createAPIURLRequest(model: MWRequestProtocol) throws -> URLRequest {
        guard 
            let serverAddress = serverAddress,
            let url = URL(string: "https://\(serverAddress):8081/api/\(model.path)") 
        else {
            throw MWServerConfigurationError.cannotCreateURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = model.requestType.rawValue
        
        // this is the only time I've let copilot take control. hmmmm...
        request.allHTTPHeaderFields = model.headers.reduce(into: [:]) { (result, header) in
            switch header {
            case .contentType(let contentType):
                result["Content-Type"] = contentType.rawValue
            }
        }
        // add auth token after we compute headers
        if model.addAuthorizationToken {
            guard let authToken = self.authToken else {
                throw MWServerConfigurationError.noAuthToken
            }
            request.addValue("Bearer \(authToken.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = model.body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
}

/// The Server revision number for API versioning
public enum MWServerVersion: String {
    /// Creation Date 05/25/2023
    case V1
}

// MARK: - Default Implementation of MWServerConfigurationProtocol

/// The object that stores server communication information
public struct MWServerConfiguration: MWServerConfigurationProtocol {
    public var serverAddress: String?
    public var serverVersion: MWServerVersion?
    public var tlsData: Data?
    public var authToken: Auth_DTO.Token?
    
    public init(_ address: String, serverVersion: MWServerVersion = .V1, tlsData: Data? = nil) {
        self.serverAddress = address
        self.serverVersion = serverVersion
        self.tlsData = tlsData
        self.authToken = nil
    }
}

/// Configuration errors
public enum MWServerConfigurationError: Error {
    /// Cannot create a URL from the given address
    case cannotCreateURL 
    /// No auth token is stored
    case noAuthToken
}

/// Constants for the server to use when computing lifetimes and stuff
public struct MWServerConstants {
    /// 3 hours
    public static let REFRESH_TOKEN_LIFETIME: Double = 60 * 60 * 3
    /// 30 minutes
    public static let ACCESS_TOKEN_LIFETIME: Double = 60 * 30
}
