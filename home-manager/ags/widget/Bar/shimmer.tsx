import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { bind, exec, Variable } from "astal"
import GdkPixbuf from "gi://GdkPixbuf?version=2.0"
import cairo from "cairo"


export default function stars(monitor: number) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="stars"
        decorated={false}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
            <overlay
            child={<box></box>}
            overlay={<box></box>}
            >
            </overlay>

        </window>
}