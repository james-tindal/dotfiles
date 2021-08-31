import { spawn as __spawn } from 'child_process'
import { writeFile } from 'fs'
import { CronJob } from 'cron'

const spawn = command => __spawn('bash', ['-c', command], { detached: true }).unref()

export const current_time = () => Math.floor(Date.now() / 1000)

export const seconds_later = seconds => {
  const d = new Date()
  d.setSeconds(d.getSeconds() + seconds)
  return Math.floor(d / 1000)
}

export const turn_off_wifi = () => spawn('networksetup -setairportpower en0 off')
export const turn_on_wifi  = () => spawn('networksetup -setairportpower en0 on ')

export const write_file = (path, data, callback) => writeFile(path, data, { flag: 'w' }, callback)

export const sleep = seconds => spawn(`sleep ${seconds}S; node checkstamp`)
