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

    // Crear el menú "Data"
    let dataMenuItem = NSMenuItem()
    self.addItem(dataMenuItem)

    let dataMenu = NSMenu(title: "Data")
    dataMenuItem.submenu = dataMenu

    // Agregar ítems al menú "Data"
    let createVolumeMenuItem = NSMenuItem(
      title: "Create Volume",
      action: #selector(createVolume),
      keyEquivalent: "n"
    )
    createVolumeMenuItem.target = self
    dataMenu.addItem(createVolumeMenuItem)

    let editVolumeMenuItem = NSMenuItem(
      title: "Edit Volume",
      action: #selector(editVolume),
      keyEquivalent: "d"
    )
    editVolumeMenuItem.target = self
    dataMenu.addItem(editVolumeMenuItem)

    let removeVolumeMenuItem = NSMenuItem(
      title: "Remove Volume",
      action: #selector(removeVolume),
      keyEquivalent: ""
    )
    removeVolumeMenuItem.target = self
    dataMenu.addItem(removeVolumeMenuItem)

    dataMenu.addItem(NSMenuItem.separator())

    let scanVolumeMenuItem = NSMenuItem(
      title: "Scan Volume",
      action: #selector(scanVolume),
      keyEquivalent: "k"
    )
    scanVolumeMenuItem.target = self
    dataMenu.addItem(scanVolumeMenuItem)
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

  // Acciones para los ítems del menú "Data"
  @objc @MainActor func createVolume() {
    let dialog = CreateVolumeDialog()
    NSApp.runModal(for: dialog)
  }

  @objc func editVolume() {
    print("Edit Volume action triggered")
  }

  @objc func removeVolume() {
    print("Remove Volume action triggered")
  }

  @objc func scanVolume() {
    print("Scan Volume action triggered")
  }

}
