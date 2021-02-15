# `hugo-server` - Automatic hugo server restart on crash
hugo-server( ) { while :; do hugo server -DEF --bind 0.0.0.0; sleep 1; done }
