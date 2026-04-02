// swift-tools-version:5.6

// Package.swift
//
// Copyright (c) 2014 - 2018 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//

import PackageDescription

let package = Package(
  name: "TomTomSwiftProtobuf",
  products: [
    .executable(name: "tt-protoc-gen-swift", targets: ["tt-protoc-gen-swift"]),
    .library(name: "TTSwiftProtobuf", type: .static, targets: ["TTSwiftProtobuf"]),
    .library(name: "TTSwiftProtobufPluginLibrary", type: .static, targets: ["TTSwiftProtobufPluginLibrary"]),
    .plugin(
        name: "TTSwiftProtobufPlugin",
        targets: ["TTSwiftProtobufPlugin"]
    ),
  ],
  targets: [
    .target(name: "TTSwiftProtobuf",
            path: "Sources/SwiftProtobuf",
            swiftSettings: [
                .unsafeFlags(["-enable-library-evolution", "-emit-module-interface"])
            ]),
    .target(name: "TTSwiftProtobufPluginLibrary",
            dependencies: ["TTSwiftProtobuf"],
            path: "Sources/SwiftProtobufPluginLibrary"),
    .executableTarget(name: "tt-protoc-gen-swift",
            dependencies: ["TTSwiftProtobufPluginLibrary", "TTSwiftProtobuf"],
            path: "Sources/protoc-gen-swift"),
    .executableTarget(name: "TTConformance",
            dependencies: ["TTSwiftProtobuf"],
            path: "Sources/Conformance"),
    .plugin(
        name: "TTSwiftProtobufPlugin",
        capability: .buildTool(),
        dependencies: [
            "tt-protoc-gen-swift"
        ],
        path: "Plugins/SwiftProtobufPlugin",
    ),
    .testTarget(name: "TTSwiftProtobufTests",
                dependencies: ["TTSwiftProtobuf"],
                path: "Tests/SwiftProtobufTests"),
    .testTarget(name: "TTSwiftProtobufPluginLibraryTests",
                dependencies: ["TTSwiftProtobufPluginLibrary"],
                path: "Tests/SwiftProtobufPluginLibraryTests"),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .version("5")]
)
