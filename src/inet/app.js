#!/usr/local/bin/node

import { unlink as delete_file } from 'fs/promises'
import { seconds_later, sleep, turn_off_wifi, turn_on_wifi, write_file } from './utilities.js'

// parse input
// toggle wifi
// create future timestamp


/***** parse input *****/
// if no match, show error message
// else, parse:
// off > 0
// Xs  > X
// Xm  > X * 60
// Xh  > X * 60 * 60

const arg = process.argv[2]
const match = /^(([0-9]+)(h|m|s))|off$/.exec(arg)

if (match === null) {
  console.error('Expected 1 argument: Duration in seconds, minutes or hours')
  process.exit(1)
}

const seconds =
  match[3] === 's'    ? match[2] * 1 :
  match[3] === 'm'    ? match[2] * 60 :
  match[3] === 'h'    ? match[2] * 60 * 60 :
  match[0] === 'off' && 0

/***** toggle wifi / create future timestamp *****/

seconds === 0
? ( turn_off_wifi()
  , delete_file('.TIMESTAMP') )
: ( write_file('.TIMESTAMP', seconds_later(seconds).toString(), process.exit)
  , turn_on_wifi()
  , sleep(seconds))


