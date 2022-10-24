#!/opt/homebrew/bin/bash
export dev_session_name='crusoe_local'
export devdir='/Users/jonathanmccreery/taxi/localdev'

declare -a services_with_docker
services_with_docker+=( 'region-coordinator' )
services_with_docker+=( 'entity' )
services_with_docker+=( 'billing' )
services_with_docker+=( 'rest-gateway' )

cd "${devdir}"

for service in "${services_with_docker[@]}"; do
  cd "${service}"/dev
  docker-compose down
  cd ../..
done

tmux kill-session -t ${dev_session_name}

colima stop

