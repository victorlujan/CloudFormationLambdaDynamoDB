.PHONT: create-bucket deploy clean invoke 

create-bucket: 	1-create-bucket.sh
				bash 1-create-bucket.sh
				
deploy:			2-deploy.sh
				bash 2-deploy.sh

				
clean:			4-cleanup.sh	
				bash 4-cleanup.sh

invoke:			3-invoke.sh
				bash 3-invoke.sh