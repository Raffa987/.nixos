import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar/Bar"
import { getLogo } from "./widget/Bar/functions"


App.start({
    css: style,
    gtkTheme: '',
    main() {
        App.get_monitors().map(Bar)
    },
})
