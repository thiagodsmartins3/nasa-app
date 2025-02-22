// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class Request {
    public enum RequestType {
        case get
        case post
        case put
        case delete
        
        var type: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }
    
    private init() { }
    
    public static func request<T: Decodable>(
        url: String,
        method: RequestType = .get,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:],
        responseModel: T.Type,
        responseHandler: @Sendable @escaping (Result<T, Error>) -> Void
    ) {
        var request: URLRequest?
        var components: URLComponents?
        
        guard let url = URL(string: url) else {
            responseHandler(Result.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if !parameters.isEmpty {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
        
        request = URLRequest(url: components!.url!)
        request?.httpMethod = method.type
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !headers.isEmpty {
            for (key, value) in headers {
                request?.addValue(key, forHTTPHeaderField: value)
            }
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                responseHandler(Result.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let post = try JSONDecoder().decode(T.self, from: data)
                responseHandler(Result.success(post))
            } catch {
                responseHandler(Result.failure(error))
            }
        }

        task.resume()
    }
    
    public static func request<T: Decodable>(
        url: String,
        method: RequestType = .get,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:],
        responseModel: T.Type
    ) async throws -> T? {
        var request: URLRequest?
        var components: URLComponents?
        
        guard let url = URL(string: url) else {
            return nil
        }
        
        components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if !parameters.isEmpty {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
        
        request = URLRequest(url: components!.url!)
        request?.httpMethod = method.type
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !headers.isEmpty {
            for (key, value) in headers {
                request?.addValue(key, forHTTPHeaderField: value)
            }
        }
    
        let (data, _) = try await URLSession.shared.data(from: components!.url!)
        
        let dataDecoded = try JSONDecoder().decode(T.self, from: data)
        
        return dataDecoded
    }
    
    public static func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
