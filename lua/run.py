import redis
import json
import subprocess


if __name__ == '__main__':
    config = json.load(open('config.json', 'r'))
    commit_script = open('commit.lua', 'r').read()
    recover_script = open('recover.lua', 'r').read()
    getlock_script = open('getLock.lua', 'r').read()

    r = redis.Redis(config['redis_addr']['host'], config['redis_addr']['port'])
    commit_script_sha = r.script_load(commit_script)
    recover_script_sha = r.script_load(recover_script)
    getlock_script_sha = r.script_load(getlock_script)

   
