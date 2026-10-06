import Foundation
import PackagePlugin

@main
struct VIPSGeneratorPlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) throws -> [Command] {
        guard target.name == "VIPS" else {
            return []
        }

        let generator = try context.tool(named: "vips-generator")

        let outputFile = context.pluginWorkDirectoryURL
            .appending(path: "Generated/VIPS.generated.swift")

        return [
            .buildCommand(
                displayName: "Generating VIPS Swift wrappers",
                executable: generator.url,
                arguments: [
                    "--output-file", outputFile.path(),
                    "--verbose",
                ],
                inputFiles: [
                    generator.url
                ],
                outputFiles: [
                    outputFile
                ]
            )
        ]
    }
}