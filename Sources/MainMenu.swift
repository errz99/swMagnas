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
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
