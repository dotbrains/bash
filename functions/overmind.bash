# Section: [Overmind](https://github.com/DarthSim/overmind) #
#-----------------------------------------------------------#

# Label: Overmind Start
# Description: Start processes.
# Parameters: $1 (optional) - Port. Default: 2990.
oms() {
  local port=${2:-2990}
  overmind start --port "$port" --port-step 10
}

# Label: Overmind Connect
# Description: Connect to running process.
# Parameters: $1 (optional) - Process. Default: "web".
omc() {
  local process="${1:-web}"
  overmind connect "$process"
}

# Label: Overmind Restart
# Description: Restart running process.
# Parameters: $1 (optional) - Process. Default: "web".
omr() {
  local process="${1:-web}"
  overmind restart "$process"
}
