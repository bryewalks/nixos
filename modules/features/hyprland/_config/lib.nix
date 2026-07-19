lib:
let
  mkLua = lib.generators.mkLuaInline;
  luaWs = ws: if builtins.isInt ws then toString ws else ''"${ws}"'';

  bind = key: dsp: {
    _args = [
      key
      (mkLua dsp)
    ];
  };
  bindOpts = key: dsp: opts: {
    _args = [
      key
      (mkLua dsp)
      opts
    ];
  };
  bindRepeat = key: dsp: bindOpts key dsp { repeating = true; };
in
{
  inherit
    mkLua
    bind
    bindOpts
    bindRepeat
    ;

  mod = suffix: mkLua ''mainMod .. " + ${suffix}"'';
  modShift = suffix: mkLua ''mainMod .. " + SHIFT + ${suffix}"'';
  modCtrl = suffix: mkLua ''mainMod .. " + CTRL + ${suffix}"'';

  launch = luaExpr: "hl.dsp.exec_cmd(${luaExpr})";
  launchTerminal = cmd: ''hl.dsp.exec_cmd(terminal .. " ${cmd}")'';
  execCmd = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  script = name: ''hl.dsp.exec_cmd("~/.config/hypr/scripts/${name}.sh")'';

  focusDirection = dir: ''hl.dsp.focus({ direction = "${dir}" })'';
  focusWorkspace = ws: "hl.dsp.focus({ workspace = ${luaWs ws} })";
  moveDirection = dir: ''hl.dsp.window.move({ direction = "${dir}" })'';
  moveWorkspace = ws: "hl.dsp.window.move({ workspace = ${luaWs ws} })";
  resizeWindow =
    x: y: "hl.dsp.window.resize({ x = ${toString x}, y = ${toString y}, relative = true })";
  toggleSpecial = name: ''hl.dsp.workspace.toggle_special("${name}")'';

  dragWindow = "hl.dsp.window.drag()";
  mouseResize = "hl.dsp.window.resize()";
  closeWindow = "hl.dsp.window.close()";
  floatWindow = action: ''hl.dsp.window.float({ action = "${action}" })'';
  fullscreen = mode: "hl.dsp.window.fullscreen(${toString mode})";

  layout = name: ''hl.dsp.layout("${name}")'';
  layoutBind =
    layouts:
    let
      entries = lib.mapAttrsToList (n: dsp: ''["${n}"] = ${dsp}'') layouts;
      table = builtins.concatStringsSep ", " entries;
    in
    ''
      function()
            local ws = hl.get_active_special_workspace() or hl.get_active_workspace()
            if not ws then return end
            local t = { ${table} }
            if t[ws.tiled_layout] then hl.dispatch(t[ws.tiled_layout]) end
          end'';

  startupHook = body: {
    _args = [
      "hyprland.start"
      (mkLua ''
        function()
        ${body}
        end
      '')
    ];
  };
}
