import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, exec, Variable } from "astal"
import GdkPixbuf from "gi://GdkPixbuf?version=2.0"
import Network from "gi://AstalNetwork"

const network = Network.get_default();
let networks = network.wifi

let win: Widget.Window;
let Revealer: Widget.Revealer
export function reveal() {
    networks.scan();
    Revealer.revealChild = !Revealer.revealChild;
    win.keymode = Revealer.revealChild ? Astal.Keymode.EXCLUSIVE : Astal.Keymode.NONE
}

const buttonslist: { [index: string]: Astal.Button } = {};
function CreateButton(Wifi: Network.AccessPoint) {
    if (buttonslist[Wifi.bssid]) return;
    //@ts-ignore
    buttonslist[Wifi.bssid] = <button
        className={"network_button"}
    >
        <box>
            <label label={Wifi.ssid}
                halign={Gtk.Align.START}
            ></label>
            <box hexpand={true}></box>
            <icon
                className="icons"
                icon={bind(Wifi, 'iconName').as(v => v)}
                halign={Gtk.Align.END}>

            </icon>
        </box>
    </button>
    return buttonslist[Wifi.bssid];
}

const builder = new Gtk.Builder();
function setupBox(self: Widget.Box) {
    function SetupAP(wifi: Network.AccessPoint) {
        const button = CreateButton(wifi);
        if (!button) return;
        self.add_child(builder, button, null);
    }

    networks.accessPoints.forEach(SetupAP)
    bind(networks, "accessPoints").subscribe(ap => {
        const bssidlist: { [index: string]: boolean } = {};
        ap.forEach(ap => {
            SetupAP(ap)
            bssidlist[ap.bssid] = true;
        })
        Object.keys(buttonslist).forEach(bssid => {
            if (bssidlist[bssid]) return;
            buttonslist[bssid].destroy();
            delete buttonslist[bssid];
        })
    })
}

export default function Network_menu(monitor: number) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    //@ts-ignore
    win = <window
        className="Menu"
        decorated={false}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.NORMAL}
        anchor={TOP | LEFT}
        application={App}
        onKeyPressEvent={(_, event) => {
            if (!Revealer.revealChild) return;
            if (event.get_keycode()[1] != 9) return;
            reveal();
        }}>
        <revealer
            setup={self => {
                Revealer = self
            }}
        >
            <eventbox
                hexpand={true}
                vexpand={true}
                className={"closeNetwork"}
                onClick={self => {
                    reveal();
                }}>
                <overlay
                    marginRight={1100}
                    marginBottom={1000}
                    overlay={<scrollable
                        className="Networkscrollable"
                    >
                        <box
                            vertical={true}
                            setup={setupBox}
                        >
                        </box>
                    </scrollable>}
                    child={<box
                        widthRequest={400}
                        heightRequest={200}
                    ></box>}>

                </overlay>
            </eventbox>
        </revealer>
    </window>
    return win
}