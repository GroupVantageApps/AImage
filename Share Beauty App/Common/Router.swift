import Alamofire

enum Router: URLRequestConvertible {
    case downloadKey
    case downloadMaster
    case downloadFile(fileId: String)
    case downloadComplete
    case downloadError
    case downloadCheck

//    static let baseURLString = Bundle.main.object(forInfoDictionaryKey: "SERVER_APP_URL") as! String
    static let baseURLString = "https://www.idnscp.net/shiseido_catalog/mng"
    static let timeOut: TimeInterval = 60 * 60 * 60

    var method: HTTPMethod {
        switch self {
        case .downloadKey:
            return .post
        case .downloadMaster:
            return .post
        case .downloadFile:
            return .post
        case .downloadComplete:
            return .post
        case .downloadError:
            return .post
        case .downloadCheck:
            return .post
        }
    }

    var path: String {
        switch self {
        case .downloadKey:
            return "/download/key"
        case .downloadMaster:
            return "/download/master"
        case .downloadFile:
            return "/download/file"
        case .downloadComplete:
            return "/download/complete"
        case .downloadError:
            return "/download/error"
        case .downloadCheck:
            return "/download/check"
        }
    }

    private func target() -> String {
        return String(DownloadConfigure.target.rawValue)
    }

    private func countryId() -> String {
        return String(LanguageConfigure.countryId)
    }

    private func key() -> String? {
        return DownloadConfigure.apiKey
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = Router.timeOut
        urlRequest.addValue(Const.userAgent, forHTTPHeaderField: "User-Agent")

        switch self {
        case .downloadKey:
            let params = ["target": target(), "countryId": countryId()]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            break
        case .downloadMaster:
            var params = ["target": target(), "countryId": countryId()]
            if let key = key() {
                params["key"] = key
            }
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            break
        case .downloadCheck,
             .downloadComplete,
             .downloadError:
            var params = [String: String]()
            if let key = key() {
                params["key"] = key
            }
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            break
        case .downloadFile(let fileId):
            var params = ["fileId": fileId]
            if let key = key() {
                params["key"] = key
            }
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            break
        }

        return urlRequest
    }
}
