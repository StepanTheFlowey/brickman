/*
 * brickman -- Brick Manager for LEGO MINDSTORMS EV3/ev3dev
 *
 * Copyright (C) 2015 David Lechner <david@lechnology.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * WifiWindow.vala: Wi-Fi Menu
 */

using Ev3devKit;

namespace BrickManager {
    public class WifiWindow : BrickManagerWindow {
        Ui.Menu powered_menu;
        Ui.Menu unpowered_menu;
        Ui.MenuItem scan_menu_item;
        Ui.CheckboxMenuItem powered_menu_item;

        bool _powered;
        public bool powered {
            get { return _powered; }
            set {
                if (value == _powered)
                    return;
                _powered = value;
                powered_menu_item.checkbox.checked = value;
                if (value) {
                    content_vbox.remove (unpowered_menu);
                    content_vbox.add (powered_menu);
                    powered_menu.insert_menu_item (powered_menu_item, scan_menu_item);
                } else {
                    content_vbox.remove (powered_menu);
                    content_vbox.add (unpowered_menu);
                    unpowered_menu.add_menu_item (powered_menu_item);
                }
            }
        }

        bool _scanning;
        public bool scanning {
            get { return _scanning; }
            set {
                _scanning = value;
                if (_scanning) {
                    scan_menu_item.label.text = "Scanning...";
                    scan_menu_item.button.can_focus = false;
                    scan_menu_item.button.focus_next (Ui.FocusDirection.DOWN);
                } else {
                    scan_menu_item.label.text = "Start scan";
                    scan_menu_item.button.can_focus = true;
                }
            }
        }

        public signal void scan_selected ();
        public signal void connection_selected (Object represented_object);

        public WifiWindow () {
            title = "Wi-Fi";

            content_vbox.spacing = 0;

            unpowered_menu = new Ui.Menu () {
                spacing = 0,
                padding = 0,
                padding_top = -1
            };
            content_vbox.add (unpowered_menu);

            powered_menu_item = new Ui.CheckboxMenuItem ("Powered");
            powered_menu_item.button.padding_top = -3;
            weak Ui.MenuItem weak_powered_menu_item = powered_menu_item;
            powered_menu_item.button.pressed.connect (() => {
                powered = !powered;
                weak_powered_menu_item.button.focus ();
            });
            powered_menu_item.checkbox.margin_top = 3;
            powered_menu_item.checkbox.margin_bottom = -3;
            unpowered_menu.add_menu_item (powered_menu_item);

            powered_menu = new Ui.Menu () {
                spacing = 1,
                padding = 0,
                padding_top = -1,
                padding_right = 1
            };

            scan_menu_item = new Ui.MenuItem ("Start scan");
            scan_menu_item.button.padding_top = -3;
            scan_menu_item.button.pressed.connect (() => scan_selected ());
            powered_menu.add_menu_item (scan_menu_item);

            var networks_label_menu_item = new Ui.MenuItem ("Networks");
            networks_label_menu_item.label.horizontal_align = Ui.WidgetAlign.CENTER;
            networks_label_menu_item.button.border_bottom = 1;
            networks_label_menu_item.button.can_focus = false;
            powered_menu.add_menu_item (networks_label_menu_item);

            scanning = false;
        }

        public void add_menu_item (Ui.MenuItem menu_item) {
            powered_menu.add_menu_item (menu_item);
        }

        public void remove_menu_item (Ui.MenuItem menu_item) {
            powered_menu.remove_menu_item (menu_item);
        }

        public Ui.MenuItem? find_menu_item (Object represented_object) {
            return powered_menu.find_menu_item<Object> (represented_object,
                (mi, o) => o == mi.represented_object);
        }
    }
}
