import pywalQute.draw

config.load_autoconfig()

pywalQute.draw.color(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
config.bind(',v', 'hint links spawn mpv {hint-url}')
config.bind(',y', 'open -t youtube.com')
config.bind('yc', 'yank inline "git clone {url}.git"')
config.bind(',m', 'open -t filmgirbot.site')
config.bind('yh', 'hint links yank')
config.bind(',w', 'spawn warp-cli set-mode warp')
config.bind(',nw', 'spawn warp-cli set-mode proxy')
config.bind(',ae', 'open -t https://stdn.iau.ir/Student/Pages/acmstd/loginPage.jsp')
config.bind(',aa', 'open -t https://eserv.iau.ir/EServices/Pages/acmstd/loginPage.jsp')
config.bind(',ig', 'open -t https://web.igap.net/app?q=@amoozeshbot')
