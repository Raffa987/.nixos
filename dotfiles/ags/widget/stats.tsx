import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { exec } from "ags/process"
import { createPoll } from "ags/time"
import requests from "../request"

const stats_label = createPoll("", 1000, '/home/raffaele/statsOverlay/build/statsGet')

function CreateBox() {
  const label = new Gtk.Label()
  stats_label.subscribe(() => label.set_label(stats_label.peek()))

  const box = new Gtk.Box()
  box.set_visible(true)
  box.insert_child_after(label, null)

  requests.listen("stat_toggle", () => {
    app.toggle_window("stats")
  })

  return box
}


export default function Stats(gdkmonitor: Gdk.Monitor) {
  const { TOP, RIGHT } = Astal.WindowAnchor


  return (
    <window
      visible={false}
      name="stats"
      class="Stats"
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | RIGHT}
      application={app} 
    > 
    <CreateBox />
    
    
    </window>
  )
}


