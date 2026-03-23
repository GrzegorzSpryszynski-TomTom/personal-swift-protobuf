// swift-tools-version:4.2

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
    .library(name: "TTSwiftProtobuf", targets: ["TTSwiftProtobuf"]),
    .library(name: "TTSwiftProtobufPluginLibrary", targets: ["TTSwiftProtobufPluginLibrary"]),
  ],
  targets: [
    .target(
      name: "TTSwiftProtobuf",
      path: "Sources/SwiftProtobuf",
    ),

    .target(
      name: "TTSwiftProtobufPluginLibrary",
      dependencies: ["TTSwiftProtobuf"],
      path: "Sources/SwiftProtobufPluginLibrary",
    ),

    .target(
      name: "tt-protoc-gen-swift",
      dependencies: ["TTSwiftProtobufPluginLibrary", "TTSwiftProtobuf"],
      path: "Sources/tt-protoc-gen-swift",
    ),

    .target(
      name: "TTConformance",
      dependencies: ["TTSwiftProtobuf"],
      path: "Sources/Conformance",
    ),

    .testTarget(
      name: "TTSwiftProtobufTests",
      dependencies: ["TTSwiftProtobuf"],
      path: "Tests/SwiftProtobufTests",
    ),

    .testTarget(
      name: "TTSwiftProtobufPluginLibraryTests",
      dependencies: ["TTSwiftProtobufPluginLibrary"],
      path: "Tests/SwiftProtobufPluginLibraryTests",
    ),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .version("5")]
)
