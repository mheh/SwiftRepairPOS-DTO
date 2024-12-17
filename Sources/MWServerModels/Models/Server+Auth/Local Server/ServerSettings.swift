import Foundation

// MARK: - Server Settings

/// Information sent to the client about server settings and store information
public struct ServerSettings_DTO: Codable {
    
    /// Settings for this specific store location
    public struct StoreLocationSettings: Codable {
        /// Whether this store is the parent store or child store
        public var masterStore: Bool
        // TODO: Create a store transfer model
        /// Array of other stores that can be used to pull information from this store's server.
        public var otherStores: Array<String>
    }
    
}
