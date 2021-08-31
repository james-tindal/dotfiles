#!/usr/local/bin/node

import { create_agent, delete_agent, log, turn_off_wifi, turn_on_wifi } from './utilities.js'

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
? ( log('Turning wifi off')
  , turn_off_wifi()
  , delete_agent() )
: ( log('Will turn wifi off in ' + match[0])
  , create_agent(seconds)
  , turn_on_wifi())


