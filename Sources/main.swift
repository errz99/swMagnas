// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift format -i Sources/*
// NSApp.setActivationPolicy(.regular)

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
  var mainWindow: MainWindow!
  var projectConfig: ProjectConfig!

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Cargar la configuración al iniciar
    if let loadedConfig = ProjectConfig.load() {
      projectConfig = loadedConfig
    } else {
      projectConfig = ProjectConfig(windowFrame: NSRect(x: 100, y: 100, width: 400, height: 300))
    }

    // Crear e inicializar la ventana principal con el marco cargado
    mainWindow = MainWindow(frame: projectConfig.windowFrame)
    mainWindow.makeKeyAndOrderFront(nil)

    // Asegurarse de que la aplicación toma el foco
    NSApp.activate(ignoringOtherApps: true)

    // Configurar el menú principal
    let mainMenu = MainMenu()
    NSApplication.shared.mainMenu = mainMenu
  }

  func applicationWillTerminate(_ notification: Notification) {
    // Guardar la configuración al cerrarse la aplicación
    projectConfig.windowFrame = mainWindow.frame
    projectConfig.save()
  }
}

// Configuración de la aplicación
let app = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
