import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { exec, execAsync } from "ags/process"
import { createPoll } from "ags/time"
import requests from "../request"
import { monitorFile, readFile } from "ags/file"

const stats_label = execAsync('/home/raffaele/statsOverlay/build/getStats')

const file_path: string = "/dev/shm/stats_output.txt"

function CreateBox() {
  const label = new Gtk.Label()
  
  monitorFile(file_path,
    () => {label.label = readFile(file_path)}
  )

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


