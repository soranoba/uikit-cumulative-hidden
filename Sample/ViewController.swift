//
//  Copyright © 2024 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import Combine
import UserNotifications

class Request {
    func makeRequest() -> URLRequest {
        return URLRequest(url: URL(string: "https://soranoba.net")!)
    }
}

@available(*, unavailable)
extension Request: Sendable {}

struct Response {
    let data: Data

    init(data: Data = Data()) {
        self.data = data
    }
}

@available(*, unavailable)
extension Response: Sendable {}


class Service {
    public enum Error: LocalizedError {
        case errorStatusCode
        case invalidResponse
    }

    func fetch1(request: Request, completion: @escaping @Sendable (sending Result<Response, Swift.Error>) -> Void) {
        URLSession.shared.dataTask(with: request.makeRequest()) { data, urlResponse, error in
            if let error {
                completion(.failure(error))
                return
            }
            if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
               !(200..<300).contains(statusCode) {
                completion(.failure(Error.errorStatusCode))
                return
            }
            if let data {
                completion(.success(Response(data: data)))
            } else {
                completion(.failure(Error.invalidResponse))
            }
        }.resume()
    }

    func fetch2(request: Request, completion: @escaping @isolated(any) (Result<Response, Swift.Error>) -> Void) {
        nonisolated(unsafe) let completion = completion

        URLSession.shared.dataTask(with: request.makeRequest()) { data, urlResponse, error in
            Task {
                if let error {
                    await completion(.failure(error))
                    return
                }
                if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                   !(200..<300).contains(statusCode) {
                    await completion(.failure(Error.errorStatusCode))
                    return
                }
                if let data {
                    await completion(.success(Response(data: data)))
                } else {
                    await completion(.failure(Error.invalidResponse))
                }
            }
        }.resume()
    }

    func fetch3(request: Request, completion: @escaping @MainActor (Result<Response, Swift.Error>) -> Void) {
        URLSession.shared.dataTask(with: request.makeRequest()) { data, urlResponse, error in
            Task { @MainActor in
                if let error {
                    completion(.failure(error))
                    return
                }
                if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                   !(200..<300).contains(statusCode) {
                    completion(.failure(Error.errorStatusCode))
                    return
                }
                if let data {
                    completion(.success(Response(data: data)))
                } else {
                    completion(.failure(Error.invalidResponse))
                }
            }
        }.resume()
    }
}

@MainActor class MainActorService {
    public enum Error: LocalizedError {
        case errorStatusCode
        case invalidResponse
    }

    func fetch(request: Request, completion: @escaping (Result<Response, Swift.Error>) -> Void) {
        nonisolated(unsafe) let completion = completion
        URLSession.shared.dataTask(with: request.makeRequest()) { data, urlResponse, error in
            Task { @MainActor in
                if let error {
                    completion(.failure(error))
                    return
                }
                if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                   !(200..<300).contains(statusCode) {
                    completion(.failure(Error.errorStatusCode))
                    return
                }
                if let data {
                    completion(.success(Response(data: data)))
                } else {
                    completion(.failure(Error.invalidResponse))
                }
            }
        }.resume()
    }
}

@MainActor
class ViewController: UIViewController {
    private let req = Request()
    private var res = Response(data: Data())
    private var isAuthorized: Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Service().fetch1(request: Request()) { [weak self] result in
            Task { @MainActor in
                if case let .success(response) = result {
                    self?.res = response
                }
            }
        }
        Service().fetch2(request: Request()) { [weak self] result in
            if case let .success(response) = result {
                self?.res = response
            }
        }
        Service().fetch3(request: Request()) { [weak self] result in
            if case let .success(response) = result {
                self?.res = response
            }
        }
        MainActorService().fetch(request: Request()) { [weak self] result in
            if case let .success(response) = result {
                self?.res = response
            }
        }
        UNUserNotificationCenter.current().requestAuthorization { @Sendable isAuthorized, _ in
            Task { @MainActor in
                self.isAuthorized = isAuthorized
            }
        }
    }
}

