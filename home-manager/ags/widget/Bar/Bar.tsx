import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { bind, exec, Variable } from "astal"
import GdkPixbuf from "gi://GdkPixbuf?version=2.0"
import Network from "gi://AstalNetwork"
import { reveal } from "./Network_menu";



/*
 * Restituisce la data formattata come DD/MM/YY hh:mm
 */
function formatDate(date: Date) {
    const d = (typeof date === 'string') ? new Date(date) : date;
    const day = String(d.getDate()).padStart(2, '0');
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const year = String(d.getFullYear()).slice(-2);
    const hours = String(d.getHours()).padStart(2, '0');
    const minutes = String(d.getMinutes()).padStart(2, '0');
    return `${hours}:${minutes} ${day}/${month}/${year}`;
}

export default function Bar(monitor: number) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        decorated={false}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <box>
            <button
                className="shutdown"
                halign={Gtk.Align.END}>
                <label
                    label=""
                    className={"icons"}></label>
            </button>
            <button
                className="network"
                onClick={self => {
                    reveal()
                }}
            >
                <icon
                    className="icons"
                    icon={bind(Network.get_default().wifi, 'iconName').as(v => v)}
                ></icon>
            </button>
            <button
                className="Firefox"
                onClicked="firefox"
            >
                <icon
                    className="icons"
                    icon="firefox"
                ></icon>
            </button>
            <button
                className="code"
                onClicked="code"
            >
                <icon
                    className="icons"
                    icon="vscode"
                ></icon>
            </button>
            <box />
            <box hexpand={true}></box>
            <button
                className="clock"
                halign={Gtk.Align.END}
            >
                <label
                    setup={self => {
                        function update() {
                            self.label = formatDate(new Date());
                        }

                        update();
                        setInterval(update, 60000); // aggiorna ogni minuto
                    }}
                ></label>
            </button>
        </box>
    </window>
}
