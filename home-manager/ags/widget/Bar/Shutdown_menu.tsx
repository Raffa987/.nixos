import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { bind, exec, Variable } from "astal"
import GdkPixbuf from "gi://GdkPixbuf?version=2.0"


let win: Widget.Window;
let Revealer: Widget.Revealer
export function revealShutdown() {
    Revealer.revealChild = !Revealer.revealChild;
    win.keymode = Revealer.revealChild ? Astal.Keymode.EXCLUSIVE : Astal.Keymode.NONE
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
            revealShutdown();
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
                    revealShutdown();
                }}>
                <overlay
                    marginRight={1100}
                    marginBottom={1000}
                    overlay={<scrollable
                        className="Networkscrollable"
                    >
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