import PackageDescription

let package = Package(
	name: "BlogParser",
    dependencies: [
        .Package(url:"https://github.com/demom/Markdown", majorVersion:0)
    ]
)
