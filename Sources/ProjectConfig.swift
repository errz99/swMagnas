import Cocoa

class ProjectConfig: NSObject, Codable {
  var windowFrame: NSRect

  init(windowFrame: NSRect) {
    self.windowFrame = windowFrame
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
}
