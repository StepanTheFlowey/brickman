/*
 * brickman -- Brick Manager for LEGO MINDSTORMS EV3/ev3dev
 *
 * Copyright (C) 2014 David Lechner <david@lechnology.com>
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
 * ShutdownDialog.vala:
 *
 * Dialog for shutting down/restarting the brick
 */

using Ev3devKit.Ui;

namespace BrickManager {
    public class ShutdownDialog : Dialog {
        Box dialog_vbox;
        Box button_vbox;
        Button power_off_button;
        Button reboot_button;
        Button cancel_button;

        public signal void power_off_button_pressed ();
        public signal void reboot_button_pressed ();

        public ShutdownDialog () {
            dialog_vbox = new Box.vertical ();
            add (dialog_vbox);

            dialog_vbox.add (new Label ("Shutdown") {
                padding = 2,
                padding_top = 0,
                border_bottom = 1
            });

            button_vbox = new Box.vertical () {
                margin = 4,
                margin_top = 2
            };
            dialog_vbox.add (button_vbox);

            power_off_button = new Button.with_label ("Power off");
            power_off_button.pressed.connect (on_power_off_button_pressed);
            button_vbox.add (power_off_button);

            reboot_button = new Button.with_label ("Reboot");
            reboot_button.pressed.connect (on_reboot_button_pressed);
            button_vbox.add (reboot_button);

            cancel_button = new Button.with_label ("Cancel");
            cancel_button.pressed.connect (on_cancel_button_pressed);
            button_vbox.add (cancel_button);
        }

        void on_power_off_button_pressed () {
            power_off_button_pressed ();
        }

        void on_reboot_button_pressed () {
            reboot_button_pressed ();
        }

        void on_cancel_button_pressed () {
            close ();
        }
    }
}
