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
  name: "GSSwiftProtobuf",
  products: [
    .executable(name: "protoc-gen-swift", targets: ["protoc-gen-swift"]),
    .library(name: "GSSwiftProtobuf", targets: ["GSSwiftProtobuf"]),
    .library(name: "GSSwiftProtobufPluginLibrary", targets: ["GSSwiftProtobufPluginLibrary"]),
    .plugin(
  name: "GSSwiftProtobufPlugin",
  targets: ["GSSwiftProtobufPlugin"]
    ),
  ],
  targets: [
    .target(name: "GSSwiftProtobuf",
      path: "Sources/SwiftProtobuf"),
    .target(name: "GSSwiftProtobufPluginLibrary",
      dependencies: ["GSSwiftProtobuf"],
      path: "Sources/SwiftProtobufPluginLibrary"),
    .executableTarget(name: "protoc-gen-swift",
      dependencies: ["GSSwiftProtobufPluginLibrary", "GSSwiftProtobuf"],
      path: "Sources/protoc-gen-swift"),
    .executableTarget(name: "Conformance",
      dependencies: ["GSSwiftProtobuf"],
      path: "Sources/Conformance"),
    .plugin(
  name: "GSSwiftProtobufPlugin",
        capability: .buildTool(),
        dependencies: [
            "protoc-gen-swift"
        ],
      path: "Plugins/SwiftProtobufPlugin",
    ),
    .testTarget(name: "SwiftProtobufTests",
    dependencies: ["GSSwiftProtobuf"],
    path: "Tests/SwiftProtobufTests"),
    .testTarget(name: "SwiftProtobufPluginLibraryTests",
    dependencies: ["GSSwiftProtobufPluginLibrary"],
    path: "Tests/SwiftProtobufPluginLibraryTests"),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .version("5")]
)
