// The Swift Programming Language
// https://docs.swift.org/swift-book
// NSApp.setActivationPolicy(.regular)

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var mainWindow: MainWindow!
    var projectConfig: ProjectConfig!
    var scanData: ScanData! = .init()

    func applicationDidFinishLaunching(_: Notification) {
        // Cargar la configuración al iniciar
        if let loadedConfig = ProjectConfig.load() {
            projectConfig = loadedConfig
        } else {
            projectConfig = ProjectConfig()
        }

        // Cargar scan data al iniciar
        if projectConfig.loadLast {
            if let lastData = projectConfig.lastDataFile {
                if let sc = ScanData.load(path: lastData) {
                    scanData = sc
                    print("data loaded with volumes count: \(scanData.volumes.count)")
                } else {
                    print("data not loaded")
                }
            } else {
                print("no last data file available")
            }
        }

        // Crear e inicializar la ventana principal con el marco cargado
        mainWindow = MainWindow(frame: projectConfig.windowFrame)
        mainWindow.makeKeyAndOrderFront(nil)

        // Asegurarse de que la aplicación toma el foco
        NSApp.activate(ignoringOtherApps: true)

        // Configurar el menú principal
        let mainMenu = MainMenu(projectConfig, scanData)
        NSApplication.shared.mainMenu = mainMenu
    }

    func applicationWillTerminate(_: Notification) {
        // Guardar la configuración al cerrarse la aplicación
        let frame = mainWindow.frame
        let myFrame = NSRect(
            x: frame.minX, y: frame.minY, width: frame.width, height: frame.height - 28
        )
        if myFrame != projectConfig.windowFrame || GlobalState.configChanged {
            projectConfig.windowFrame = myFrame
            projectConfig.save()
        }
    }
}

// Configuración de la aplicación
let app = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
