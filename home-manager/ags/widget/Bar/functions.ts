export function getLogo (appName: string){
    const allLogsPaths : string = '/home/raffale/run/current-system/sw/share/applications/'
    let logoPath : string = allLogsPaths.concat(appName);
    return logoPath
}