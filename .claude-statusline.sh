#!/bin/bash
input=$(cat)

dir=$(printf '%s' "$input" | /usr/bin/jq -r '.workspace.current_dir // .cwd // ""')
branch=""
if [ -n "$dir" ] && [ -d "$dir" ]; then
  branch=$(git -C "$dir" symbolic-ref --short -q HEAD 2>/dev/null) ||
    branch=$(git -C "$dir" rev-parse --short -q HEAD 2>/dev/null) || branch=""
fi

printf '%s' "$input" | /usr/bin/jq -r --arg branch "$branch" '
  def dim:   "\u001b[2m" + . + "\u001b[0m";
  def paint($p):
    (if   $p == null then "\u001b[2m"
     elif $p >= 90   then "\u001b[31m"
     elif $p >= 70   then "\u001b[33m"
     else                 "\u001b[32m" end) + . + "\u001b[0m";

  def epoch($r):
    if   $r == null           then null
    elif ($r | type) == "number" then $r
    else (try ($r | fromdateiso8601) catch null) end;

  def clock($e):
    if ($e | strflocaltime("%Y-%m-%d")) == (now | strflocaltime("%Y-%m-%d"))
    then ($e | strflocaltime("%H:%M"))
    else ($e | strflocaltime("%a %H:%M")) end;

  def resets($r):
    (epoch($r) // null) as $e
    | if $e == null or $e <= now then "" else " (\(clock($e)))" end;

  def window($label; $w):
    if $w == null or $w.used_percentage == null then empty
    else ("\($label) \($w.used_percentage | floor)%" | paint($w.used_percentage))
         + (resets($w.resets_at) | dim)
    end;

  (.workspace.current_dir // .cwd // "") as $dir
  | (.model.display_name // "") as $model
  | (.effort.level // "") as $effort
  | [
      ($dir | split("/") | last // "" | if . == "" then empty else dim end),
      ($branch | if . == "" then empty else dim end),
      ([$model, (if $effort == "" then empty else "(\($effort))" end)]
       | join(" ") | if . == "" then empty else dim end),
      (.context_window.used_percentage as $c
       | if $c == null then empty else ("ctx \($c | floor)%" | paint($c)) end),
      window("5h"; .rate_limits.five_hour),
      window("7d"; .rate_limits.seven_day)
    ]
  | map(select(. != null and . != ""))
  | join(" \u001b[2m·\u001b[0m ")
'
