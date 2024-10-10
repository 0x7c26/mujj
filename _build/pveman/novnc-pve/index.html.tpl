<!DOCTYPE html>
<html lang="en" class="noVNC_loading">
<head>

    <!--
    noVNC example: simple example using default UI
    Copyright (C) 2019 The noVNC Authors
    noVNC is licensed under the MPL 2.0 (see LICENSE.txt)
    This file is licensed under the 2-Clause BSD license (see LICENSE.txt).

    Connect parameters are provided in query string:
        http://example.com/?host=HOST&port=PORT&encrypt=1
    or the fragment:
        http://example.com/#host=HOST&port=PORT&encrypt=1
    -->
    <title>[% nodename %] - Proxmox Console</title>

    <meta charset="utf-8">

    <!-- Apple iOS Safari settings -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <!-- Stylesheets -->
    <link rel="stylesheet" href="/novnc/app/styles/base.css?ver=1.4.0-1" />
    <link rel="stylesheet" href="/novnc/app/styles/input.css?ver=1.4.0-1" />
    <link rel="stylesheet" href="/novnc/app/styles/pve.css?ver=1.4.0-1" />

    <!-- Images that will later appear via CSS -->
    <link rel="preload" as="image" href="/novnc/app/images/info.svg">
    <link rel="preload" as="image" href="/novnc/app/images/error.svg">
    <link rel="preload" as="image" href="/novnc/app/images/warning.svg">

    <script type="module" crossorigin="anonymous" src="/novnc/app/error-handler.js?ver=1.4.0-1"></script>
    <script type="text/javascript">
	if (typeof(PVE) === 'undefined') PVE = {};
	PVE.UserName = '[% username %]';
	PVE.CSRFPreventionToken = '[% token %]';
	INCLUDE_URI='/novnc/include';
    </script>
    <script crossorigin=anonymous" src="/novnc/app.js?ver=1.4.0-1"></script>
</head>

<body>

    <div id="noVNC_fallback_error" class="noVNC_center">
        <div>
            <div>noVNC encountered an error:</div>
            <br>
            <div id="noVNC_fallback_errormsg"></div>
        </div>
    </div>

    <!-- noVNC Control Bar -->
    <div id="noVNC_control_bar_anchor" class="noVNC_vcenter">

        <div id="noVNC_control_bar">
            <div id="noVNC_control_bar_handle" title="Hide/Show the control bar"><div></div></div>

            <div class="noVNC_scroll">

            <h1 class="noVNC_logo" translate="no"><span>no</span><br>VNC</h1>

            <hr>

            <!-- Drag/Pan the viewport -->
            <input type="image" alt="Drag" src="/novnc/app/images/drag.svg"
                id="noVNC_view_drag_button" class="noVNC_button noVNC_hidden"
                title="Move/Drag Viewport">

            <!--noVNC Touch Device only buttons-->
            <div id="noVNC_mobile_buttons">
                <input type="image" alt="Keyboard" src="/novnc/app/images/keyboard.svg"
                    id="noVNC_keyboard_button" class="noVNC_button" title="Show Keyboard">
            </div>

            <!-- Extra manual keys -->
            <input type="image" alt="Extra keys" src="/novnc/app/images/toggleextrakeys.svg"
                id="noVNC_toggle_extra_keys_button" class="noVNC_button"
                title="Show Extra Keys">
            <div class="noVNC_vcenter">
            <div id="noVNC_modifiers" class="noVNC_panel">
                <input type="image" alt="Ctrl" src="/novnc/app/images/ctrl.svg"
                    id="noVNC_toggle_ctrl_button" class="noVNC_button"
                    title="Toggle Ctrl">
                <input type="image" alt="Alt" src="/novnc/app/images/alt.svg"
                    id="noVNC_toggle_alt_button" class="noVNC_button"
                    title="Toggle Alt">
                <input type="image" alt="Windows" src="/novnc/app/images/windows.svg"
                    id="noVNC_toggle_windows_button" class="noVNC_button"
                    title="Toggle Windows">
                <input type="image" alt="Tab" src="/novnc/app/images/tab.svg"
                    id="noVNC_send_tab_button" class="noVNC_button"
                    title="Send Tab">
                <input type="image" alt="Esc" src="/novnc/app/images/esc.svg"
                    id="noVNC_send_esc_button" class="noVNC_button"
                    title="Send Escape">
                <input type="image" alt="Ctrl+Alt+Del" src="/novnc/app/images/ctrlaltdel.svg"
                    id="noVNC_send_ctrl_alt_del_button" class="noVNC_button"
                    title="Send Ctrl-Alt-Del">
            </div>
            </div>

            <!-- Shutdown/Reboot -->
            <input type="image" alt="Shutdown/Reboot" src="/novnc/app/images/power.svg"
                id="noVNC_power_button" class="noVNC_button"
                title="Shutdown/Reboot...">
            <div class="noVNC_vcenter">
            <div id="noVNC_power" class="noVNC_panel">
                <div class="noVNC_heading">
                    <img alt="" src="/novnc/app/images/power.svg"> Power
                </div>
                <input type="button" id="noVNC_shutdown_button" value="Shutdown">
                <input type="button" id="noVNC_reboot_button" value="Reboot">
                <input type="button" id="noVNC_reset_button" value="Reset">
            </div>
            </div>

            <!-- Clipboard -->
            <input type="image" alt="Clipboard" src="/novnc/app/images/clipboard.svg"
                id="noVNC_clipboard_button" class="noVNC_button"
                title="Clipboard">
            <div class="noVNC_vcenter">
            <div id="noVNC_clipboard" class="noVNC_panel">
                <div class="noVNC_heading">
                    <img alt="" src="/novnc/app/images/clipboard.svg"> Clipboard
                </div>
                <p class="noVNC_subheading">
                    Edit clipboard content in the textarea below.
                </p>
                <textarea id="noVNC_clipboard_text" rows=5></textarea>
            </div>
            </div>

            <!-- Toggle fullscreen -->
            <input type="image" alt="Fullscreen" src="/novnc/app/images/fullscreen.svg"
                id="noVNC_fullscreen_button" class="noVNC_button noVNC_hidden"
                title="Full Screen">

            <!-- Settings -->
            <input type="image" alt="Settings" src="/novnc/app/images/settings.svg"
                id="noVNC_settings_button" class="noVNC_button"
                title="Settings">
            <div class="noVNC_vcenter">
            <div id="noVNC_settings" class="noVNC_panel">
                <div class="noVNC_heading">
                    <img alt="" src="/novnc/app/images/settings.svg"> Settings
                </div>
                <ul>
                    <li style="display:none;">
                        <label><input id="noVNC_setting_shared" type="checkbox"> Shared Mode</label>
                    </li>
                    <li>
                        <label><input id="noVNC_setting_view_only" type="checkbox"> View Only</label>
                    </li>
                    <li><hr></li>
                    <li>
                        <label><input id="noVNC_setting_view_clip" type="checkbox"> Clip to Window</label>
                    </li>
                    <li>
                        <label><input id="noVNC_setting_local_cursor" type="checkbox" /> Local Cursor</label>
                    </li>
                    <li>
                        <label><input id="noVNC_setting_autoresize" type="checkbox" /> Autoresize Window</label>
                    </li>
                    <li>
                        <label for="noVNC_setting_resize">Scaling Mode:</label>
                        <select id="noVNC_setting_resize" name="vncResize">
                            <option value="off">Off</option>
                            <option value="scale">Local Scaling</option>
                        </select>
                    </li>
                    <li><hr></li>
                    <li style="display:none;">
                        <div class="noVNC_expander">Advanced</div>
                        <div><ul>
                            <li>
                                <label for="noVNC_setting_quality">Quality:</label>
                                <input id="noVNC_setting_quality" type="range" min="0" max="9" value="6">
                            </li>
                            <li>
                                <label for="noVNC_setting_compression">Compression level:</label>
                                <input id="noVNC_setting_compression" type="range" min="0" max="9" value="2">
                            </li>
                            <li><hr></li>
                            <li>
                                <label for="noVNC_setting_repeaterID">Repeater ID:</label>
                                <input id="noVNC_setting_repeaterID" type="text" value="">
                            </li>
                            <li>
                                <div class="noVNC_expander">WebSocket</div>
                                <div><ul>
                                    <li>
                                        <label><input id="noVNC_setting_encrypt" type="checkbox"> Encrypt</label>
                                    </li>
                                    <li>
                                        <label for="noVNC_setting_host">Host:</label>
                                        <input id="noVNC_setting_host">
                                    </li>
                                    <li>
                                        <label for="noVNC_setting_port">Port:</label>
                                        <input id="noVNC_setting_port" type="number">
                                    </li>
                                    <li>
                                        <label for="noVNC_setting_path">Path:</label>
                                        <input id="noVNC_setting_path" type="text" value="websockify">
                                    </li>
                                </ul></div>
                            </li>
                            <li><hr></li>
                            <li>
                                <label><input id="noVNC_setting_reconnect" type="checkbox"> Automatic Reconnect</label>
                            </li>
                            <li>
                                <label for="noVNC_setting_reconnect_delay">Reconnect Delay (ms):</label>
                                <input id="noVNC_setting_reconnect_delay" type="number">
                            </li>
                            <li><hr></li>
                            <li>
                                <label><input id="noVNC_setting_show_dot" type="checkbox"> Show Dot when No Cursor</label>
                            </li>
                            <li><hr></li>
                            <!-- Logging selection dropdown -->
                            <li>
                                <label>Logging:
                                    <select id="noVNC_setting_logging" name="vncLogging">
                                    </select>
                                </label>
                            </li>
                        </ul></div>
                    </li>
                    <li class="noVNC_version_separator"><hr></li>
                    <li class="noVNC_version_wrapper">
                        <span>Version:</span>
                        <span class="noVNC_version"></span>
                    </li>
                </ul>
            </div>
            </div>

	    <!-- PVE Commands -->
            <input type="image" alt="Commands" src="/novnc/app/images/power.svg"
                id="pve_commands_button" class="noVNC_button"
                title="Commands" />

            <div class="noVNC_vcenter">
            <div id="pve_commands" class="noVNC_panel">
                <div class="noVNC_heading">
                    <img src="/novnc/app/images/power.svg"> Commands
                </div>
		<input id="pve_command_start" type="button" value="Start" />
		<input id="pve_command_shutdown" type="button" value="Shutdown" />
		<input id="pve_command_stop" type="button" value="Hard Stop" />
		<input id="pve_command_reset" type="button" value="Hard Reset" />
		<input id="pve_command_suspend" type="button" value="Suspend" />
		<input id="pve_command_resume" type="button" value="Resume" />
		<input id="pve_command_reload" type="button" value="Reload noVNC" />
	    </div>
	    </div>


            <!-- Connection Controls -->
            <input type="image" alt="Disconnect" src="/novnc/app/images/disconnect.svg"
                id="noVNC_disconnect_button" class="noVNC_button"
                title="Disconnect">

            </div>
        </div>

    </div> <!-- End of noVNC_control_bar -->

    <div id="noVNC_hint_anchor" class="noVNC_vcenter">
        <div id="noVNC_control_bar_hint">
        </div>
    </div>

    <!-- Status Dialog -->
    <div id="noVNC_status"></div>

    <!-- Connect button -->
    <div class="noVNC_center">
        <div id="noVNC_connect_dlg">
            <p class="noVNC_logo" translate="no"><span>no</span>VNC</p>
            <div>
                <button id="noVNC_connect_button">
                    <img alt="" src="/novnc/app/images/connect.svg"> Connect
                </button>
            </div>
        </div>
    </div>

    <!-- Server Key Verification Dialog -->
    <div class="noVNC_center noVNC_connect_layer">
    <div id="noVNC_verify_server_dlg" class="noVNC_panel"><form>
        <div class="noVNC_heading">
            Server identity
        </div>
        <div>
            The server has provided the following identifying information:
        </div>
        <div id="noVNC_fingerprint_block">
            <b>Fingerprint:</b>
            <span id="noVNC_fingerprint"></span>
        </div>
        <div>
            Please verify that the information is correct and press
            "Approve". Otherwise press "Reject".
        </div>
        <div>
            <input id="noVNC_approve_server_button" type="submit" value="Approve" class="noVNC_submit">
            <input id="noVNC_reject_server_button" type="button" value="Reject" class="noVNC_submit">
        </div>
    </form></div>
    </div>

    <div class="noVNC_center">
        <div id="pve_start_dlg">
            <div id="pve_start_info">Guest not running</div>
            <div id="pve_start_button"><div>
                <img alt="" src="/novnc/app/images/power.svg"> Start Now
            </div></div>
        </div>
    </div>

    <!-- Password Dialog -->
    <div class="noVNC_center noVNC_connect_layer">
    <div id="noVNC_credentials_dlg" class="noVNC_panel"><form>
        <div class="noVNC_heading">
            Credentials
        </div>
        <div id="noVNC_username_block">
            <label for="noVNC_username_input">Username:</label>
            <input id="noVNC_username_input">
        </div>
        <div id="noVNC_password_block">
            <label for="noVNC_password_input">Password:</label>
            <input id="noVNC_password_input" type="password">
        </div>
        <div>
            <input id="noVNC_credentials_button" type="submit" value="Send Credentials" class="noVNC_submit">
        </div>
    </form></div>
    </div>

    <!-- Transition Screens -->
    <div id="noVNC_transition">
        <div id="noVNC_transition_text"></div>
        <div>
        <input type="button" id="noVNC_cancel_reconnect_button" value="Cancel" class="noVNC_submit">
        </div>
        <div class="noVNC_spinner"></div>
    </div>

    <!-- This is where the RFB elements will attach -->
    <div id="noVNC_container">
        <!-- Note that Google Chrome on Android doesn't respect any of these,
             html attributes which attempt to disable text suggestions on the
             on-screen keyboard. Let's hope Chrome implements the ime-mode
             style for example -->
        <textarea id="noVNC_keyboardinput" autocapitalize="off"
            autocomplete="off" spellcheck="false" tabindex="-1"></textarea>
    </div>

    <audio id="noVNC_bell">
        <source src="/novnc/app/sounds/bell.oga" type="audio/ogg">
        <source src="/novnc/app/sounds/bell.mp3" type="audio/mpeg">
    </audio>
 </body>
</html>
