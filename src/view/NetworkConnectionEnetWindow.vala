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
 * NetworkConnectionEnetWindow.vala:
 *
 * Displays ENET properties of a network connection.
 */

using Ev3devKit.Ui;

namespace BrickManager {
    class NetworkConnectionEnetWindow : BrickManagerWindow {
        Label method_label;
        Label interface_label;
        Label address_label;
        Label mtu_label;

        public string method {
            set { method_label.text = value; }
        }

        public string interface {
            set { interface_label.text = value; }
        }

        public string address {
            set { address_label.text = value; }
        }

        public int mtu {
            set { mtu_label.text = "%d".printf (value); }
        }

        public NetworkConnectionEnetWindow (string name) {
            title = name;

            var scroll = new Scroll.vertical () {
                padding = 0,
                padding_top = -1
            };
            content_vbox.add (scroll);

            var vbox = new Box.vertical ();
            scroll.add (vbox);

            vbox.add (new Label ("Interface:"));
            interface_label = new Label ();
            vbox.add (interface_label);

            vbox.add (new Label ("MAC address:") {
                margin_top = 4
            });
            address_label = new Label ();
            vbox.add (address_label);

            vbox.add (new Label ("MTU:") {
                margin_top = 4
            });
            mtu_label = new Label ();
            vbox.add (mtu_label);

            vbox.add (new Label ("Method:") {
                margin_top = 4
            });
            method_label = new Label () {
                margin_bottom = 2
            };
            vbox.add (method_label);
        }
    }
}
