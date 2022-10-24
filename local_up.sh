#!/opt/homebrew/bin/bash
export dev_session_name='crusoe_local'
export devdir='/Users/jonathanmccreery/taxi/localdev'

declare -a services
services+=('agent')
services+=('mdu')
services+=('region')
services+=('synchronizer')
services+=('entity')
services+=('billing')
services+=('rest-gateway')
services+=('portal-backend')
services+=('portal')
services+=('admin-gateway')
services+=('portal-admin')

declare -A service_cmds
service_cmds=( 
  ['agent']='cd agent; sudo make setup; make dev; make run' 
  ['mdu']='cd mdu-coordinator; make dev; make run' 
  ['region']='cd region-coordinator; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..;  make run'
  ['synchronizer']='cd region-coordinator; make run-synchronizer'
  ['entity']='cd entity; make dev; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..; make run'
  ['billing']='cd billing; make dev; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..; make run'
  ['rest-gateway']='cd rest-gateway/dev; docker-compose up -d; cd ..; make run'
  ['portal-backend']='cd portal-backend; make run'
  ['portal']='cd portal; yarn install; yarn dev'
  ['admin-gateway']='cd admin-gateway; make run'
  ['portal-admin']='cd portal-admin; yarn install; yarn dev'
)

tmux has-session -t ${dev_session_name} 2>/dev/null 1>&2
if [ $? -eq 0 ]; then 
  echo "tmux development session already exists! bailing."
  exit 1
fi

colima start

cd "${devdir}"

tmux new-session -s ${dev_session_name} -d
#tmux set-environment -t ${dev_session_name} CGO_LDFLAGS '-L/opt/homebrew/Cellar/libvirt/8.8.0/lib'
#tmux set -wg remain-on-exit on
for service in "${services[@]}"; do
  cmd="${service_cmds[${service}]}"
  echo "cmd: ${service}, value: ${cmd}"
  tmux new-window -t ${dev_session_name} -n ${service} "${cmd}"
  sleep 30
done


