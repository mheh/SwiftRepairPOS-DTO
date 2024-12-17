import Foundation

/// For models that have an ID and created/updated sent from server
protocol ModelDateProtocol {
    /// Created at date
    var createdAt: Date { get }
    /// Updated at date
    var updatedAt: Date { get }
}
