/// ===----------------------------------------------------------------------===//
//
// This source file is part of the Hummingbird server framework project
//
// Copyright (c) 2021-2021 the Hummingbird authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See hummingbird/CONTRIBUTORS.txt for the list of Hummingbird authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Hummingbird
import HummingbirdCoreXCT
import NIOCore

func run(identifier: String) {
    do {
        let setup = try Setup { app in
            app.router.post { _ -> HTTPResponseStatus in
                return .ok
            }
        }

        measure(identifier: identifier) {
            let iterations = 1000
            for _ in 0..<iterations {
                let future = setup.client.post("/", body: ByteBuffer(string: "Hello, world!"))
                _ = try? future.wait()
            }
            return iterations
        }
    } catch {
        print(error)
    }
}
