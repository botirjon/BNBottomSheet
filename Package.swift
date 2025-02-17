
import PackageDescription

let package = Package(
    name: "BNBottomSheet",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BNBottomSheet",
            targets: ["BNBottomSheet"]
        ),
    ],
    targets: [
        .target(
            name: "BNBottomSheet",
            path: "Sources"
        )
    ]
)
