// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift format -i Sources/*
// NSApp.setActivationPolicy(.regular)

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
  var mainWindow: MainWindow!

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Configurar el menú principal
    let mainMenu = MainMenu()
    NSApplication.shared.mainMenu = mainMenu

    // Crear e inicializar la ventana principal
    mainWindow = MainWindow()
    mainWindow.makeKeyAndOrderFront(nil)
  }

  func applicationWillTerminate(_ notification: Notification) {
    // Código para limpiar recursos si es necesario
  }
}

// Configuración de la aplicación
let app = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
