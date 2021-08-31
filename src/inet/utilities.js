import { spawn as __spawn } from 'child_process'
import { writeFile, unlink } from 'fs/promises'
import path from 'path'
import plist from 'plist'

export const log = console.log.bind(console)
const spawn = command => __spawn('bash', ['-c', command], { detached: true }).unref()

export const seconds_later = seconds => {
  const d = new Date()
  d.setSeconds(d.getSeconds() + seconds)
  return d
}

export const turn_off_wifi = () => spawn('networksetup -setairportpower en0 off')
export const turn_on_wifi  = () => spawn('networksetup -setairportpower en0 on ')
const unload_agent = path => __spawn('launchctl', ['unload', '-w', path])
const load_agent = path => __spawn('launchctl', ['load', '-w', path])

export const write_file = (path, data) => writeFile(path, data).catch(log)
export const delete_agent = () => unlink(agent_path).catch(() => {})


const agent_name = 'james-tindal.inet'
const agent_dir = process.env.HOME + '/Library/LaunchAgents'
const agent_path = path.resolve(agent_dir, agent_name + '.plist')


const build_plist = (Minute, Hour, Day, Month) => plist.build({
  Label: agent_name,
  ProgramArguments: ['networksetup', '-setairportpower', 'en0', 'off'],
  StartCalendarInterval: { Minute, Hour }
})

export const create_agent = seconds => {
  const date = seconds_later(seconds)
  write_file(agent_path, build_plist(
    date.getMinutes(),
    date.getHours(),
    date.getDate(),
    date.getMonth() + 1
  ))
  unload_agent(agent_name)
  load_agent(agent_name)
}

