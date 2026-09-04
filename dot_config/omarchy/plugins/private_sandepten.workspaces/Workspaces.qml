import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "sandepten.workspaces"

  // Set via `omarchy bar set sandepten.workspaces showAppIcons true --json`
  // Accepts bool true or string "true" (bar set without --json stores a string).
  readonly property var showIconsRaw: setting("showAppIcons", false)
  readonly property bool showAppIcons: showIconsRaw === true || showIconsRaw === "true" || showIconsRaw === 1

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  function workspaceIds() {
    var ids = [1, 2, 3, 4, 5]
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  // Step through workspaceIds() explicitly (with wraparound) instead of
  // Hyprland's e+1/e-1, which only cycles workspaces that already exist and
  // can never land on an empty one.
  function stepWorkspace(delta) {
    if (!root.bar) return
    var ids = root.workspaceIds()
    if (ids.length === 0) return
    var cur = Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : -1
    var i = ids.indexOf(cur)
    var step = delta > 0 ? 1 : -1
    if (i === -1) i = delta > 0 ? -1 : 0
    var next = ids[(i + step + ids.length) % ids.length]
    root.focusWorkspace(next)
  }

  function handleWheel(delta) {
    if (delta === 0) return
    // Scroll down = higher workspace number, scroll up = lower.
    // (negated: stepWorkspace treats positive delta as "next".)
    root.stepWorkspace(-delta)
  }

  // App id for one Hyprland toplevel window.
  // NOTE: HyprlandToplevel has no appId/class property of its own — the
  // wayland handle carries appId, and lastIpcObject carries class.
  function toplevelAppId(t) {
    if (!t) return ""
    try {
      if (t.wayland && t.wayland.appId) {
        var a = String(t.wayland.appId)
        if (a.length > 0) return a
      }
    } catch (errWayland) {}
    try {
      var ipc = t.lastIpcObject
      if (ipc) {
        var c = String(ipc.class || ipc.initialClass || "")
        if (c.length > 0) return c
      }
    } catch (errIpc) {}
    return ""
  }

  // First (most relevant) app id in a workspace.
  // Prefers the focused window when it lives here, else the last toplevel.
  function firstAppId(workspace) {
    if (!workspace || !workspace.toplevels) return ""
    var tops = workspace.toplevels.values
    if (!tops || tops.length === 0) return ""
    try {
      var focused = Hyprland.focusedWorkspace
      var active = ToplevelManager.activeToplevel
      if (focused && workspace.id === focused.id && active) {
        var aid = String(active.appId || "")
        if (aid.length > 0) return aid
      }
    } catch (errActive) {}
    for (var i = tops.length - 1; i >= 0; i--) {
      var id = root.toplevelAppId(tops[i])
      if (id.length > 0) return id
    }
    return ""
  }

  function appIconSource(workspace, appId) {
    var aid = String(appId || "")
    if (aid.length === 0) return ""
    // 1. Quickshell's fuzzy desktop-entry lookup (matches id, name,
    //    startupClass, exec...). Handles e.g. "zen" -> zen.desktop.
    try {
      var guess = DesktopEntries.heuristicLookup(aid)
      if (guess && guess.icon && String(guess.icon).length > 0) return Quickshell.iconPath(guess.icon, true)
    } catch (errGuess) {}
    // 2. Exact desktop-id lookup.
    try {
      var exact = DesktopEntries.byId(aid) || DesktopEntries.byId(aid + ".desktop")
      if (exact && exact.icon && String(exact.icon).length > 0) return Quickshell.iconPath(exact.icon, true)
    } catch (errExact) {}
    // 3. Manual scan matching startupClass / id / name (case-insensitive).
    try {
      var values = DesktopEntries.applications.values || []
      var lower = aid.toLowerCase()
      for (var i = 0; i < values.length; i++) {
        var e = values[i]
        if (!e) continue
        var eid = String(e.id || "").toLowerCase()
        var sclass = String(e.startupClass || "").toLowerCase()
        var ename = String(e.name || "").toLowerCase()
        if (sclass === lower || eid === lower || ename === lower) {
          if (e.icon && String(e.icon).length > 0) return Quickshell.iconPath(e.icon, true)
          break
        }
      }
    } catch (errScan) {}
    // 4. Direct themed lookup by app id (works when icon name == app id).
    try {
      var direct = Quickshell.iconPath(aid, true)
      if (direct && String(direct).length > 0) return direct
      var low = Quickshell.iconPath(aid.toLowerCase(), true)
      if (low && String(low).length > 0) return low
    } catch (errDirect) {}
    return ""
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
        readonly property string appId: root.firstAppId(workspace)
        readonly property string iconSource: root.showAppIcons ? root.appIconSource(workspace, appId) : ""
        readonly property bool showIcon: root.showAppIcons && iconSource !== "" && occupied

        bar: root.bar
        text: focused && !showIcon ? "󰮯" : (modelData === 10 ? "0" : String(modelData))
        labelVisible: !showIcon || iconImg.status === Image.Error
        keepSpace: true
        active: focused
        tooltipText: showIcon && appId !== "" ? ("Workspace " + modelData + " — " + appId) : ("Workspace " + modelData)
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(20)
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
        onWheelMoved: function(delta) { root.handleWheel(delta) }

        // Focus circle + tint marking the active workspace, visible in both
        // icon and number modes. Sized from the smaller button dimension so
        // it stays a true circle even though the button is wider than tall.
        Rectangle {
          anchors.centerIn: parent
          width: Math.min(parent.width, parent.height) - 2
          height: width
          radius: width / 2
          color: Color.urgent
          opacity: 0.25
          visible: parent.focused
        }

        Rectangle {
          anchors.centerIn: parent
          width: Math.min(parent.width, parent.height) - 2
          height: width
          radius: width / 2
          color: "transparent"
          border.width: 2
          border.color: Color.urgent
          visible: parent.focused
        }

        Image {
          id: iconImg
          anchors.centerIn: parent
          width: Style.space(14)
          height: Style.space(14)
          fillMode: Image.PreserveAspectFit
          smooth: true
          asynchronous: true
          visible: parent.showIcon && status !== Image.Error
          sourceSize.width: Math.round(width * Screen.devicePixelRatio)
          sourceSize.height: Math.round(height * Screen.devicePixelRatio)
          source: parent.iconSource
        }
      }
    }
  }
}
