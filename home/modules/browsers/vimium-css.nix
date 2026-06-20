palette: ''
  /* Link hint boxes */
  div > .vimiumHintMarker {
    background: ${palette.selection} !important;
    font-family: "CaskaydiaCove Nerd Font" !important;
    font-size: 12px !important;
    border: 0.1em solid ${palette.foreground} !important;
    box-shadow: 0em 0.1em 0.6em 0.1em rgba(0, 0, 0, 0.4) !important;
  }

  /* Link hint text */
  div > .vimiumHintMarker span {
    color: ${palette.purple} !important;
    font-size: inherit !important;
    text-shadow: none !important;
  }

  /* Link hint matching characters */
  div > .vimiumHintMarker > .matchingCharacter {
    color: ${palette.currentLine} !important;
  }

  /* HUD ("heads-up display") bar */
  div.vimiumHUD {
    background: ${palette.background};
    border: 1px solid ${palette.currentLine};
  }

  div.vimiumHUD .vimiumHUDSearchArea {
    background: ${palette.background};
  }

  div.vimiumHUD .hud-find {
    background: ${palette.background};
    border: none;
    color: ${palette.foreground};
  }

  div.vimiumHUD span#hud-find-input {
    color: ${palette.foreground};
  }

  div.vimiumHUD span#hud-match-count {
    color: ${palette.currentLine};
  }

  div.vimiumHUD .vimiumHUDSearchAreaInner {
    color: ${palette.currentLine};
  }

  #vomnibar {
    background-color: ${palette.selection};
  }

  #vomnibar input {
    color: ${palette.foreground};
    font: -moz-window;
    font-size: 20px;
    height: 34px;
    margin-bottom: 0;
    padding: 4px;
    background-color: ${palette.background};
    border-radius: 3px;
    border: 1px solid ${palette.currentLine};
    box-shadow: ${palette.purple} 0px 0px 1px;
    width: 100%;
    outline: none;
    box-sizing: border-box;
  }

  #vomnibar .vomnibarSearchArea {
    display: block;
    padding: 10px;
    background-color: ${palette.currentLine};
    border-radius: 4px 4px 0 0;
    border-bottom: 0px solid ${palette.purple};
  }

  #vomnibar ul {
    background-color: ${palette.selection};
    border-radius: 0 0 4px 4px;
    list-style: none;
    padding-top: 0;
    padding-bottom: 0;
    margin-block-start: 2px;
    margin-block-end: 0px;
  }

  #vomnibar li {
    border-bottom: 1px solid ${palette.currentLine};
    line-height: 1.1em;
    padding: 7px 10px;
    font-size: 16px;
    color: ${palette.foreground};
    position: relative;
    display: list-item;
    margin: auto;
  }

  #vomnibar li .vomnibarBottomHalf {
    font-size: 15px;
    margin-top: 3px;
    padding: 2px 0;
  }

  #vomnibar li .vomnibarSource {
    color: ${palette.purple};
    margin-right: 4px;
  }

  #vomnibar li .vomnibarRelevancy {
    position: absolute;
    right: 0;
    top: 0;
    padding: 5px;
    background-color: ${palette.background};
    color: ${palette.foreground};
    font-family: monospace;
    width: 100px;
    overflow: hidden;
  }

  #vomnibar li .vomnibarUrl {
    white-space: nowrap;
    color: ${palette.green};
  }

  #vomnibar li .vomnibarMatch {
    font-weight: bold;
    color: ${palette.orange};
  }

  #vomnibar li em,
  #vomnibar li .vomnibarTitle {
    color: ${palette.foreground};
    margin-left: 4px;
    font-weight: normal;
  }

  #vomnibar li em { font-style: italic; }

  #vomnibar li em .vomnibarMatch,
  #vomnibar li .vomnibarTitle .vomnibarMatch {
    color: ${palette.orange};
  }

  #vomnibar li.vomnibarSelected {
    background-color: ${palette.currentLine};
    font-weight: normal;
  }

  #vomnibarInput::selection {
    background-color: ${palette.cyan};
  }
''
