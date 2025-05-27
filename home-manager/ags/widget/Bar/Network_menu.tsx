import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, exec, Variable } from "astal"
import GdkPixbuf from "gi://GdkPixbuf?version=2.0"
import Network from "gi://AstalNetwork"

let Revealer: Widget.Revealer
export function reveal() {
    Revealer.revealChild = !Revealer.revealChild;
}

let networks = Network.get_default().wifi
function CreateButton(Wifi: Network.AccessPoint) {
    return <button>
        <label label={Wifi.ssid}></label>
    </button>
}

const builder = new Gtk.Builder();
function setupBox(self: Widget.Box) {
    networks.accessPoints.forEach(wifi => {
        self.add_child(builder, CreateButton(wifi), null);
    })
}

export default function Network_menu(monitor: number) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Menu"
        decorated={false}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.NORMAL}
        anchor={TOP | LEFT}
        application={App}><revealer
            setup={self => {
                Revealer = self
            }}
        >
            <scrollable
            widthRequest={500}
            heightRequest={500}>
                <box
                    vertical={true}
                    setup={setupBox}
                >
                </box>
            </scrollable>
        </revealer>
    </window>
}