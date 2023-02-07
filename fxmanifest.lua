fx_version 'adamant'
games { 'rdr3' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'NotSarin#0001'

description 'RSG Note Script'

server_scripts {
    "server/main.lua",
}
client_scripts {
    "client/main.lua",
}
ui_page {
    'nui/ui.html',
}
files {
    'nui/ui.html',
    'nui/css/main.css',
    'nui/js/app.js',
}
