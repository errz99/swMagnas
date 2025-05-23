import Cocoa

enum Language: Codable {
    case english
    case spanish
}

class ProjectConfig: NSObject, Codable {
    var windowFrames: [NSRect]
    var language: Language
    var lastDataFile: URL?
    var loadLast: Bool
    var defaultDataDir: URL?

    override init() {
        windowFrames = [
            NSRect(x: 100, y: 100, width: 400, height: 300), // main window
            NSRect(x: 100, y: 100, width: 400, height: 200) // create volume dialog
        ]

        language = .english
        lastDataFile = nil
        loadLast = true
        defaultDataDir = nil
    }

    // Ruta estándar para guardar la configuración del proyecto
    private static var configFilePath: URL {
        let appSupportDir = FileManager.default.urls(
            for: .applicationSupportDirectory, in: .userDomainMask
        ).first!
        let appDir = appSupportDir.appendingPathComponent("swMagnas")
        try? FileManager.default.createDirectory(at: appDir, withIntermediateDirectories: true)
        return appDir.appendingPathComponent("config.json")
    }

    // Guardar la configuración en un archivo JSON
    func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            try data.write(to: ProjectConfig.configFilePath)
            print("Configuración guardada en: \(ProjectConfig.configFilePath)")
        } catch {
            print("Error al guardar la configuración: \(error)")
        }
    }

    // Cargar la configuración desde un archivo JSON
    static func load() -> ProjectConfig? {
        do {
            let data = try Data(contentsOf: configFilePath)
            let decoder = JSONDecoder()
            return try decoder.decode(ProjectConfig.self, from: data)
        } catch {
            print("No se pudo cargar la configuración: \(error)")
            return nil
        }
    }

    @MainActor func updateWindowFrame(n: Int, with frame: NSRect) {
        let myFrame = NSRect(
            x: frame.minX, y: frame.minY, width: frame.width, height: frame.height - 28
        )
        if myFrame != windowFrames[n] {
            windowFrames[n] = myFrame
            GlobalState.configChanged = true
        }
    }
}
