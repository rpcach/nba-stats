# nba-stats

As of 2020-04-14 (but definitely earlier), the necessary webpages to scrape on stats.nba.com are no longer accessible.
As such, this project is closed.

Here is an example of the returned stats of the teams in a user-selected fantasy basketball league on ESPN. 

1. User enters the URL for their fantasy basketball league's home page. (this must be public)
2. Player names are then scraped from the team rosters
3. Player names are matched with players from the database
4. Player's average stats from the previous year are pulled
5. The selected week's list of games is looked at to identify how many times each player will play
6. (Player's avg stats) x (# of games in week) = Results, which represent a team's potential final stats for the week. This makes it easy for you to compare how your team will match up against an opponents in this week or the following week.
7. Results are exported to a pre-formatted Excel file that has columns individually highlighted to make it easier to see the strong and weak teams for a certain stat category. (The coloring of the **Team** column indicates the split between East/West conferences)

Sadly, starting with 2018, ESPN redesigned their website, so the app no longer worked. At some point, code for the Shiny web app (which is useless now) was lost between working on 2 computers.

![Good times...](https://raw.githubusercontent.com/rpcach/nba-stats/master/league.png)
