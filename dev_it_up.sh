# agen÷
cmd_agent='cd agent; sudo rm -rf /var/cruse; make setup; make dev; make run'

# mdu
cmd_mdu='cd ..; cd mdu-coordinator; make dev; make run'

# region coordinator
colima start
cmd_region='cd ..; cd region-coordinator; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..;  make run'
cmd_run_sync='make run-synchronizer'

# entity
cmd_entity='cd ..; cd entity; make dev; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..; make run'

# billing
cmd_billing='cd ..; cd billing; make dev; cd dev; docker-compose up; docker-compose down; cd db; ./migrations.sh; cd ..; docker-compose up -d; cd ..; make run'

# rest-gateway
cmd_rest='cd ..; cd rest-gateway/dev; docker-compose up -d; cd ..; make run'

# portal-backend
cmd_prtl_bkend='cd ..; cd portal-backend; make run'

# portal
cmd_portal='cd ..; cd portal; yarn install; yarn dev'

# admin-gateway
cmd_admin_gtwy='cd ..; cd admin-gateway; make run'

# portal-admin
cmd_prtl_admin='cd ..; cd portal-admin; yarn install; yarn dev'

