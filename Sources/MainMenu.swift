import Cocoa

class MainMenu: NSMenu {
    var createVolumeDialog: CreateVolumeDialog?
    var config: ProjectConfig!
    var scanData: ScanData!
    var mainWindow: MainWindow!

    init(_ window: MainWindow, _ config: ProjectConfig, _ scanData: ScanData) {
        super.init(title: "MainMenu")
        self.config = config
        self.scanData = scanData
        mainWindow = window

        // Crear el menú principal
        let mainAppMenu = NSMenuItem()
        addItem(mainAppMenu)

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
        addItem(fileMenuItem)

        let fileMenu = NSMenu(title: "File")
        fileMenuItem.submenu = fileMenu

        // Agregar items al menú "File"
        let openFileMenuItem = NSMenuItem(
            title: "Open",
            action: #selector(openFile),
            keyEquivalent: "o"
        )
        openFileMenuItem.target = self
        fileMenu.addItem(openFileMenuItem)

        fileMenu.addItem(NSMenuItem.separator())

        // Agregar "Save" al menú "File"
        let saveMenuItem = NSMenuItem(
            title: "Save",
            action: #selector(saveFile),
            keyEquivalent: "s"
        )
        saveMenuItem.target = self
        fileMenu.addItem(saveMenuItem)

        // Agregar "Save As" al menú "File"
        let saveAsMenuItem = NSMenuItem(
            title: "Save As",
            action: #selector(saveFileAs),
            keyEquivalent: "S"
        )
        saveAsMenuItem.keyEquivalentModifierMask = [.shift, .command]
        saveAsMenuItem.target = self
        fileMenu.addItem(saveAsMenuItem)

        // Crear el menú "Data"
        let dataMenuItem = NSMenuItem()
        addItem(dataMenuItem)

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

    @available(*, unavailable)
    required init(coder _: NSCoder) {
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
                if let sc = ScanData.load(url: result.absoluteURL) {
                    scanData = sc
                    config.lastDataFile = result.absoluteURL
                    GlobalState.configChanged = true
                    mainWindow.title = result.lastPathComponent + GlobalState.appNameForTitle
                    print("data loaded with volumes count: \(scanData.volumes.count)")
                } else {
                    print("data not loaded")
                }
            }
        } else {
            print("No se seleccionó ningún archivo.")
        }
    }

    // Acción para "Save"
    @objc @MainActor func saveFile() {
        // Guarda el fichero de datos activo
        if let lastDataFile = config.lastDataFile {
            scanData.save(url: lastDataFile)

            if GlobalState.dataChanged {
                GlobalState.dataChanged = false
                if let mainWindow = GlobalState.mainWindow {
                    mainWindow.title = lastDataFile.lastPathComponent + GlobalState.appNameForTitle
                }
            }
        }
    }

    // Acción para "Save As"
    @objc @MainActor func saveFileAs() {
        let dialog = NSSavePanel()
        dialog.title = "Save As"
        dialog.showsResizeIndicator = true
        dialog.canCreateDirectories = true
        dialog.showsHiddenFiles = false

        if dialog.runModal() == .OK {
            if let result = dialog.url {
                scanData.save(url: result)
                config.lastDataFile = result.absoluteURL
                GlobalState.configChanged = true
                mainWindow.title = result.lastPathComponent + GlobalState.appNameForTitle
                print("Archivo guardado: \(result.path)")
            }
        } else {
            print("No se guardó ningun archivo.")
        }
    }

    @objc @MainActor func createVolume() {
        if let dialog = createVolumeDialog {
            NSApp.runModal(for: dialog)
        } else {
            createVolumeDialog = CreateVolumeDialog(config, data: scanData)
            NSApp.runModal(for: createVolumeDialog!)
            // createVolumeDialog = nil // Liberar la referencia manualmente
        }
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
