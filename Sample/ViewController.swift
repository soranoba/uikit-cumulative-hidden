//
//  Copyright © 2024 Hinagiku Soranoba. All rights reserved.
//

import UIKit
import Combine

class SendableWrapper<Value>: @unchecked Sendable {
    let value: Value

    init(_ value: Value) {
        self.value = value
    }
}

class Test: @unchecked Sendable {
    class Data: @unchecked Sendable {
        @Published var value1: Int = 0
        @Published var value2: Int = 0
    }

    private let queue = DispatchQueue(label: "label")
    private var cancellables: [AnyCancellable] = []

    func execute1() async {
        let data = Data()
        cancellables = [
            data.$value1.sink { value1 in
                print("no scheduler: argument = \(value1), current = \(data.value1)")
            },
        ]
        print("write value -> start")
        data.value1 = 1
        print("write value -> end")
        print("-------")

        cancellables = [
            data.$value1.subscribe(on: DispatchQueue(label: "1")).sink { value1 in
                print("subscribe scheduler: argument = \(value1), current = \(data.value1), isMainThread = \(Thread.isMainThread)")
            },
            data.$value1.receive(on: DispatchQueue(label: "2")).sink { value1 in
                print("receive scheduler: argument = \(value1), current = \(data.value1), isMainThread = \(Thread.isMainThread)")
            },
        ]

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 100)
            print("write value -> start")
            data.value1 = 2
            print("write value -> end")
        }
    }

    func execute2() async {
        let data = Data()
        cancellables = [
            data.$value1.sink { value1 in
                print("--- receive: \(value1)")
                usleep(2000)
                print("--- receive = \(value1), current = \(data.value1)")
            },
        ]
        (1...5).forEach { value in
            DispatchQueue.global().async {
                usleep(useconds_t(value * 1000))
                print("enqueue: \(value)")
                data.value1 = value
                print("end: \(value), current = \(data.value1)")
            }
        }
    }

    func execute3() async {
        let data = Data()
        cancellables = [
            data.$value1.receive(on: queue).sink { value1 in
                usleep(1000)
                print("receive = \(value1), current = \(data.value1)")
            },
        ]
        let lock = NSLock()
        (1...5).forEach { value in
            DispatchQueue.global().async {
                usleep(useconds_t(Int.random(in: 0...100)))
                lock.withLock {
                    print("enqueue: \(value)")
                    data.value1 = value
                }
            }
        }
    }

    @MainActor func execute4() async {
        let data = Data()
        cancellables = [
            data.$value1.subscribe(on: DispatchQueue.main).sink { value1 in
                print("argument = \(value1), current = \(data.value1), isMainThread = \(Thread.isMainThread)")
            },
        ]

        for num in 1...5 {
            data.value1 = num
        }
        try? await Task.sleep(for: .seconds(0.1))
        for num in 6...10 {
            data.value1 = num
        }
    }

    func execute5() async {
        let data = Data()
        cancellables = [
            Publishers.CombineLatest(data.$value1, data.$value2)
                .debounce(for: .seconds(0), scheduler: DispatchQueue.main)
                .sink { value1, value2 in
                    print("receive: value1 = \(value1), value2 = \(value2) / current: value1 = \(data.value1), value2 = \(data.value2)")
                }
        ]

        Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.1))
            (11...20).forEach { data.value1 = $0 }
            (21...30).forEach { data.value2 = $0 }
        }
    }
}

class ViewController: UIViewController {
    let test = Test()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await test.execute5()
        }
    }
}

