/*
 * brickman -- Brick Manager for LEGO MINDSTORMS EV3/ev3dev
 *
 * Copyright (C) 2014-2015 David Lechner <david@lechnology.com>
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
 * NetworkStatusWindow.vala:
 *
 * Monitors network status and performs other network related functions
 */

using Ev3devKit;

namespace BrickManager {
    public class NetworkStatusWindow : BrickManagerWindow {
        Ui.Label state_label;
        Ui.Menu menu;
        Ui.MenuItem network_connections_menu_item;
        Ui.CheckboxMenuItem offline_mode_menu_item;

        public string state {
            get { return state_label.text; }
            set { state_label.text = value; }
        }

        public bool offline_mode {
            get { return offline_mode_menu_item.checkbox.checked; }
            set { offline_mode_menu_item.checkbox.checked = value; }
        }

        public signal void network_connections_selected ();
        public signal void tethering_selected ();

        public NetworkStatusWindow (string display_name) {
            title = display_name;

            var state_hbox = new Ui.Box.horizontal () {
                horizontal_align = Ui.WidgetAlign.CENTER,
                vertical_align = Ui.WidgetAlign.CENTER,
                padding_top = -5
            };
            content_vbox.add (state_hbox);

            state_hbox.add (new Ui.Label ("Status:") {
                horizontal_align = Ui.WidgetAlign.END,
                margin_right = 4
            });

            state_label = new Ui.Label ("???") {
                horizontal_align = Ui.WidgetAlign.START
            };
            state_hbox.add (state_label);

            menu = new Ui.Menu () {
                spacing = 0,
                padding = 0,
                padding_top = 1,
                border_top = 1
            };
            content_vbox.add (menu);

            network_connections_menu_item = new Ui.MenuItem.with_right_arrow ("All connections");
            network_connections_menu_item.button.padding_top = -3;
            network_connections_menu_item.button.pressed.connect (() => network_connections_selected ());
            menu.add_menu_item (network_connections_menu_item);

            var tethering_menu_item = new Ui.MenuItem.with_right_arrow ("Tethering");
            tethering_menu_item.button.padding_top = -3;
            tethering_menu_item.button.pressed.connect (() => tethering_selected ());
            menu.add_menu_item (tethering_menu_item);

            offline_mode_menu_item = new Ui.CheckboxMenuItem ("Offline mode");
            offline_mode_menu_item.button.padding_top = -3;
            offline_mode_menu_item.checkbox.margin_top = 3;
            offline_mode_menu_item.checkbox.margin_bottom = -3;
            offline_mode_menu_item.checkbox.notify["checked"].connect ((s, p) => {
                notify_property ("offline-mode");
            });
            menu.add_menu_item (offline_mode_menu_item);
        }

        public void add_technology_controller (IBrickManagerModule controller) {
            var menu_item = new Ui.MenuItem.with_right_arrow (controller.display_name) {
                represented_object = controller
            };
            menu_item.button.padding_top = -3;
            menu_item.button.pressed.connect (() => controller.show_main_window ());
            menu.insert_menu_item (menu_item, network_connections_menu_item);
        }
    }
}
