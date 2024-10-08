# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {
    # 'gs': 'https://www.scholar.google.com.scholar?hl=en&q={}',
    'gs': 'https://scholar.google.co.uk/scholar?hl=en&q={}',
    'DEFAULT': 'https://www.google.com.ar/search?q={}',
    'ddg': 'https://duckduckgo.com/?q={}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'ytp': 'https://www.youtube.com/results?sp=EgIQAw%253D%253D&search_query={}',
    'sh' : 'http://sci-hub.se/{}'
}



# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Width (in pixels or as percentage of the window) of the tab bar if
# it's vertical.
# Type: PercOrInt
c.tabs.width = '15%'

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'top'
c.tabs.max_width = 300


c.hints.mode = 'number'

config.bind('cc', 'download-open')
config.bind('cv', 'spawn mpv {url}')
# config.bind('<cc>' 'download-open')

# try adblock

import sys, os
sys.path.append(os.path.join(sys.path[0], '/home/johannes/jblock'))
config.source("/home/johannes/jblock/jblock/integrations/qutebrowser.py")

config.bind(';m', 'hint links userscript ~/qb-yt-viewer')


# config.bind(';m', 'hint links userscript ~/.config/qutebrowser/userscripts/view_in_mpv')

