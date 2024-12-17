// MARK: - Document Settings
/// Settings for Documents: Quotes, Invoices, Services, Rentals
public struct DocumentSettings_DTO: Codable {
    public struct footers {
        /// Footer specific to service orders
        public var serviceFooter: String
        /// Footer specific to quotes
        public var quoteFooter: String
        /// Footer specific to invoices
        public var invoiceFooter: String
        /// Footer specific to rentals
        public var rentalFooter: String
        /// Footer that's global to all documents
        public var globalFooter: String
    }
}
