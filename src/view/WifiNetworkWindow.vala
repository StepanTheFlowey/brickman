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
 * WifiNetworkWindow.vala: View for a single Wi-Fi network.
 */

using Ev3devKit;

namespace BrickManager {
    public class WifiNetworkWindow : BrickManagerWindow {
        Ui.Label state_label;
        Ui.Menu menu;
        Ui.MenuItem action_menu_item;
        Ui.MenuItem forget_menu_item;
        Ui.MenuItem network_connection_menu_item;

        public string status {
            get { return state_label.text; }
            set { state_label.text = value; }
        }

        public string action {
            get { return action_menu_item.label.text; }
            set { action_menu_item.label.text = value; }
        }

        bool _can_forget = true;
        public bool can_forget {
            get { return _can_forget; }
            set {
                if (value == _can_forget) {
                    return;
                }
                if (value) {
                    menu.insert_menu_item (forget_menu_item,
                        network_connection_menu_item);
                } else {
                    menu.remove_menu_item (forget_menu_item);
                }
                _can_forget = value;
            }
        }

        public signal void status_selected ();
        public signal void action_selected ();
        public signal void forget_selected ();
        public signal void network_connection_selected ();

        public WifiNetworkWindow (string name) {
            title = name;

            var state_hbox = new Ui.Box.horizontal () {
                horizontal_align = Ui.WidgetAlign.CENTER,
                vertical_align = Ui.WidgetAlign.CENTER,
                padding_top = -5
            };
            content_vbox.add (state_hbox);

            state_hbox.add (new Ui.Label ("State:") {
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

            var status_menu_item = new Ui.MenuItem.with_right_arrow ("Status");
            status_menu_item.button.padding_top = -3;
            status_menu_item.button.pressed.connect (() => status_selected ());
            menu.add_menu_item (status_menu_item);

            action_menu_item = new Ui.MenuItem ("???");
            action_menu_item.button.padding_top = -3;
            action_menu_item.button.pressed.connect (() => action_selected ());
            menu.add_menu_item (action_menu_item);

            forget_menu_item = new Ui.MenuItem ("Forget");
            forget_menu_item.button.padding_top = -3;
            forget_menu_item.button.pressed.connect (() => forget_selected ());
            menu.add_menu_item (forget_menu_item);

            network_connection_menu_item = new Ui.MenuItem.with_right_arrow ("Network Connection");
            network_connection_menu_item.button.padding_top = -3;
            network_connection_menu_item.button.pressed.connect (() => network_connection_selected ());
            menu.add_menu_item (network_connection_menu_item);
        }
    }
}
