#!/Users/mark.honomichl/.virtualenvs/toggl/bin/python

activate_this = "/Users/mark.honomichl/.virtualenvs/toggl/bin/activate_this.py"
with open(activate_this) as f:
    code = compile(f.read(), activate_this, 'exec')
    exec(code, dict(__file__=activate_this))

import requests
from datetime import date
from time import sleep

toggl_token = ''
toggl_api_url = "https://www.toggl.com/api/v8"
toggl_reports_url = "https://toggl.com/reports/api/v2"
today = date.today().strftime("%Y-%m-%d")


def get_workspaces():
    r = requests.get(toggl_api_url + "/workspaces", auth=(toggl_token, 'api_token'))
    return r.json()


def get_tags(workspace):
    r = requests.get(toggl_api_url + "/workspaces/" + str(workspace) + "/tags", auth=(toggl_token, 'api_token'))
    return r.json()


def get_report(tid, wid):
    total_time = 0
    r = requests.get(toggl_reports_url + "/summary", auth=(toggl_token, 'api_token'), params={
        'workspace_id': wid,
        'since': today,
        'until': today,
        'tag_ids': tid,
        'user_agent': 'pyrequests'
    })
    milliseconds = r.json()['total_grand']
    if milliseconds is not None:
        seconds, milliseconds = divmod(milliseconds,1000)
        minutes, seconds = divmod(seconds, 60)
        hours, minutes = divmod(minutes, 60)
        total_time = str(hours) + ":" + str(minutes) + ":" + str(seconds)

    return total_time


for workspace in get_workspaces():
    for tag in get_tags(workspace['id']):
        total_time = get_report(tag['id'], tag['wid'])
        print("{:30}: {}".format(tag['name'], total_time))
        sleep(2)
