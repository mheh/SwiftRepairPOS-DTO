import XCTest
@testable import MWServerModels

final class MWServerModelsTests: XCTestCase {
    var serverConfig: MWServerConfiguration!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serverConfig = MWServerConfiguration("localhost")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serverConfig = nil
    }
    
    
    // MARK: - Test Config Object populates Authorization Token
    
    /// Try to create a URL request to login with our default implementation
    func testConfigObjectRequestWithoutAuthTokenHappy() throws {
        XCTAssertNil(serverConfig.authToken)

        let loginRequest = Auth_DTO.Login.init(body: .init(email: "test@test.com", password: "test"))
        let request = try serverConfig.createAPIURLRequest(model: loginRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://localhost:8081/api/auth/login")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertNil(request.allHTTPHeaderFields?["Authorization"])
        XCTAssertNotNil(request.httpBody)
    }

    /// Try to create a URL request to see if we're authenticated
    func testConfigObjectRequestWithAuthTokenHappy() throws {
        serverConfig.authToken = Auth_DTO.Token.init(accessToken: "12345", accessExpiration: "\(Date())",
                                                   refreshToken: "refresh_string", refreshExpiration: "\(Date())")
        XCTAssertNotNil(serverConfig.authToken)

        let currentSessionRequest = User_DTO.V1.CurrentUserRequest.init()
        let request = try serverConfig.createAPIURLRequest(model: currentSessionRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://localhost:8081/api/users/current")
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer 12345")
        XCTAssertNil(request.httpBody)
    }

    /// Fail to create URL request when we don't have a token
    func testConfigObjectRequestWithAuthTokenFails() throws {
        serverConfig.authToken = nil
        XCTAssertNil(serverConfig.authToken)

        let currentSessionRequest = User_DTO.V1.CurrentUserRequest.init()
        XCTAssertThrowsError(try serverConfig.createAPIURLRequest(model: currentSessionRequest)) { error in
            XCTAssertEqual(error as? MWServerConfigurationError, MWServerConfigurationError.noAuthToken)
        }
    }
    
    
    // MARK: - Test decode types
    func testDecodingSingleDecodableType_Happy() async throws {
        // pretend we're the server, form a response
        let loginResponse = Auth_DTO.Login.Response(
            token: .init(accessToken: "12345", accessExpiration: "\(Date())",
                         refreshToken: "refresh_token", refreshExpiration: "\(Date())"),
            user: .init(id: UUID(), username: "johnjacob", fullname: "John Jacob", email: "test@test.com", isAdmin: false, isActive: true, isReset: true)
                    //.init(id: UUID(), fullname: "John Jacob", email: "test@test.com", isAdmin: false)
        )
        let data = try JSONEncoder().encode(loginResponse)
        let resp = try JSONDecoder().decode(Auth_DTO.Login.Response.self, from: data)
        
        XCTAssertEqual(resp.token.accessToken, loginResponse.token.accessToken)
        XCTAssertEqual(resp.user.fullname, loginResponse.user.fullname)
    }
}
