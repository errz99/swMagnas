import Cocoa

class MainMenu: NSMenu {
  init() {
    super.init(title: "MainMenu")

    // Crear el menú principal
    let mainAppMenu = NSMenuItem()
    self.addItem(mainAppMenu)

    // Crear el menú de la aplicación
    let appMenu = NSMenu(title: "Application")
    mainAppMenu.submenu = appMenu

    // Agregar la opción "Quit"
    let quitMenuItem = NSMenuItem(
      title: "Quit",
      action: #selector(NSApplication.terminate(_:)),
      keyEquivalent: "q"
    )
    appMenu.addItem(quitMenuItem)

    // Crear el menú "File"
    let fileMenuItem = NSMenuItem()
    self.addItem(fileMenuItem)

    let fileMenu = NSMenu(title: "File")
    fileMenuItem.submenu = fileMenu

    // Agregar "Open File" al menú "File"
    let openFileMenuItem = NSMenuItem(
      title: "Open File",
      action: #selector(openFile),
      keyEquivalent: "o"
    )
    openFileMenuItem.target = self
    fileMenu.addItem(openFileMenuItem)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Acción para "Open File"
  @objc @MainActor func openFile() {
    let dialog = NSOpenPanel()
    dialog.title = "Choose a file"
    dialog.showsResizeIndicator = true
    dialog.showsHiddenFiles = false
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false

    if dialog.runModal() == .OK {
      if let result = dialog.url {
        print("Archivo seleccionado: \(result.path)")
      }
    } else {
      print("No se seleccionó ningún archivo.")
    }
  }
}
