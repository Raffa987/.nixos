import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar/Bar"
import Network_menu from "./widget/Bar/Network_menu"


App.start({
    css: style,
    gtkTheme: '',
    main() {
        Bar(0),
        Network_menu(0)
    },
})
