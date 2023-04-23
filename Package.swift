// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "CameLLMCommon",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
  ],
  products: [
    .library(
      name: "CameLLMCommon",
      targets: ["CameLLMCommon"]),
    .library(
      name: "CameLLMCommonObjCxx",
      targets: ["CameLLMCommonObjCxx"]),
  ],
  dependencies: [
    .package(url: "https://github.com/CameLLM/CameLLM.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "CameLLMCommon",
      dependencies: ["CameLLMCommonObjCxx", "CameLLM"]
    ),
    .target(
      name: "CameLLMCommonObjCxx",
      dependencies: [
        .product(name: "CameLLMObjCxx", package: "CameLLM")
      ],
      cSettings: [.unsafeFlags(["-fmodules", "-fcxx-modules"])]
    )
  ],
  cxxLanguageStandard: .cxx11
)
