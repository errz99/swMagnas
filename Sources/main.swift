// The Swift Programming Language
// https://docs.swift.org/swift-book
// NSApp.setActivationPolicy(.regular)

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var mainWindow: MainWindow!
    var projectConfig: ProjectConfig!
    var scanData: ScanData = .init()

    func applicationDidFinishLaunching(_: Notification) {
        // Cargar la configuración al iniciar
        if let loadedConfig = ProjectConfig.load() {
            projectConfig = loadedConfig
        } else {
            projectConfig = ProjectConfig()
        }

        // Cargar scan data al iniciar
        var updateTitle = false
        if projectConfig.loadLast {
            if let lastData = projectConfig.lastDataFile {
                if let sc = ScanData.load(url: lastData) {
                    scanData = sc
                    updateTitle = true
                    print("data loaded with volumes count: \(scanData.volumes.count)")
                } else {
                    print("data not loaded")
                }
            } else {
                print("no last data file available")
            }
        }

        // Crear e inicializar la ventana principal con el marco cargado
        mainWindow = MainWindow(projectConfig)
        mainWindow.makeKeyAndOrderFront(nil)

        if updateTitle {
            if let lastDataFile = projectConfig.lastDataFile {
                mainWindow.title = lastDataFile.lastPathComponent + GlobalState.appNameForTitle
            }
        }

        // Asegurarse de que la aplicación toma el foco
        NSApp.activate(ignoringOtherApps: true)

        // Configurar el menú principal
        let mainMenu = MainMenu(mainWindow, projectConfig, scanData)
        NSApplication.shared.mainMenu = mainMenu
    }

    func applicationWillTerminate(_: Notification) {
        // Guardar la configuración al cerrarse la aplicación
        projectConfig.updateWindowFrame(n: 0, with: mainWindow.frame)
        if GlobalState.configChanged {
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
