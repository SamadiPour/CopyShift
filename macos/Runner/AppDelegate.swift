import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        changeDockIcon(showIcon: false)
        return false
    }

    override func applicationShouldHandleReopen(_: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window in NSApp.windows {
                if !window.isVisible {
                    window.setIsVisible(true)
                }
                window.makeKeyAndOrderFront(self)
                NSApp.activate(ignoringOtherApps: true)
            }
        }
        changeDockIcon(showIcon: true)
        return true
    }

    func changeDockIcon(showIcon state: Bool) {
        if state {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
        }
        else {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)
        }
    }
}
