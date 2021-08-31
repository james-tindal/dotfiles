import { readFile as read_file, unlink as delete_file } from 'fs/promises'
import { current_time, turn_off_wifi } from './utilities.js'
const do_nothing = () => {}

import { spawn } from 'child_process'
const say = say => spawn('bash', ['-c', `say ${say}`])


read_file('.TIMESTAMP')
.then(str =>
  Number(str) === 0 || isNaN(Number(str))
  ? Promise.reject()
  : Promise.resolve(Number(str)) )
.then(turn_off_time =>
  current_time() >= turn_off_time 
  ? ( turn_off_wifi()
    , say('wifi off')
    , delete_file('.TIMESTAMP'))
  : do_nothing)
  .catch(do_nothing)
// .catch(d => say('Error: ' + d))

